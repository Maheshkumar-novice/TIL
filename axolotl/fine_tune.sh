#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 -u HF_USERNAME [options] [additional args for fine-tuning]"
    echo "Options:"
    echo "  -m, --models-folder PATH   Specify the models folder (default: ./models)"
    echo "  -u, --hf-username NAME     Specify the Hugging Face username (mandatory)"
    echo "  -U, --upload-only          Only perform uploads for models that haven't been uploaded"
    echo "  -h, --help                 Display this help message"
    exit 1
}

# Function to ensure a directory exists
ensure_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Created directory: $dir"
    fi
}

# Function to run fine-tuning for a single configuration
run_fine_tuning() {
    local model_name="$1"
    local config_path="$2"
    local output_dir="$3"
    shift 3
    local additional_args="$@"

    ensure_dir "$output_dir"
    local log_file="./${model_name}_$(basename "$config_path" .yml)_training.log"

    echo "Starting fine-tuning for $config_path. Logs will be written to $log_file"
    
    if accelerate launch -m axolotl.cli.train "$config_path" --output_dir "$output_dir" $additional_args 2>&1 | tee "$log_file"; then
        echo "Completed fine-tuning for $config_path. Full logs available in $log_file"
        return 0
    else
        echo "Fine-tuning failed for $config_path. Check logs in $log_file for details."
        return 1
    fi
}

# Function to merge and upload a model to Hugging Face
upload_to_hf() {
    local model_name="$1"
    local config_path="$2"
    local output_dir="$3"
    local repo_name="$4"

    ensure_dir "$output_dir"
    local merged_model_dir="${output_dir}/merged_model"
    ensure_dir "$merged_model_dir"

    local merge_log="./${model_name}_$(basename "$config_path" .yml)_merge.log"
    local upload_log="./${model_name}_$(basename "$config_path" .yml)_upload.log"
    local upload_flag="${output_dir}/.upload_complete"

    echo "Merging and uploading model from $output_dir to Hugging Face as $repo_name"
    ls $output_dir
    
    # Merge the model
    if CUDA_VISIBLE_DEVICES="" python3 -m axolotl.cli.merge_lora "$config_path" --lora_model_dir "$output_dir" --output_dir "$merged_model_dir" 2>&1 | tee "$merge_log"; then
        echo "Model merged successfully. Proceeding with upload."
        
        # Upload the merged model
        if huggingface-cli upload "$repo_name" "$merged_model_dir" --repo-type model 2>&1 | tee "$upload_log"; then
            echo "Uploaded $repo_name to Hugging Face"
            touch "$upload_flag"
        else
            echo "Failed to upload $repo_name to Hugging Face. Check $upload_log for details."
            return 1
        fi
    else
        echo "Failed to merge model for $repo_name. Check $merge_log for details."
        return 1
    fi

    echo "Removing output_dir as merge & upload is complete"
    rm -rf $output_dir
}

# Default values
models_folder="./models"
hf_username=""
upload_only=false

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--models-folder)
            models_folder="$2"
            shift 2
            ;;
        -u|--hf-username)
            hf_username="$2"
            shift 2
            ;;
        -U|--upload-only)
            upload_only=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            break
            ;;
    esac
done

# Check if HF username is provided
if [ -z "$hf_username" ]; then
    echo "Error: Hugging Face username is mandatory."
    usage
fi

echo "Using models folder: $models_folder"
echo "Using Hugging Face username: $hf_username"
if $upload_only; then
    echo "Running in upload-only mode"
fi

ensure_dir "$models_folder"

# Array to store background job PIDs
upload_jobs=()

# Iterate through each model folder
for model_folder in "$models_folder"/*; do
    if [ -d "$model_folder" ]; then
        model_name=$(basename "$model_folder")
        
        # Find all configuration files in the model folder
        for config_file in "$model_folder"/config_*.yml; do
            if [ -f "$config_file" ]; then
                config_name=$(basename "$config_file" .yml)
                output_dir="$model_folder/output_$config_name"
                upload_flag="${output_dir}/.upload_complete"

                if [ -d "$output_dir" ] && ! $upload_only; then
                    echo "Warning: Output directory $output_dir already exists. Skipping this model."
                    continue
                fi

                if ! $upload_only; then
                    # Run fine-tuning sequentially
                    if run_fine_tuning "$model_name" "$config_file" "$output_dir" "$@"; then
                        # If fine-tuning succeeds, start upload in background
                        upload_to_hf "$model_name" "$config_file" "$output_dir" "$hf_username/${model_name}-${config_name}" &
                        upload_pid=$!
                        upload_jobs+=($upload_pid)
                        echo "Started upload job for ${model_name}-${config_name} with PID $upload_pid"
                    fi
                elif [ ! -f "$upload_flag" ]; then
                    # If in upload-only mode and the model hasn't been uploaded
                    upload_to_hf "$model_name" "$config_file" "$output_dir" "$hf_username/${model_name}-${config_name}" &
                    upload_pid=$!
                    upload_jobs+=($upload_pid)
                    echo "Started upload job for ${model_name}-${config_name} with PID $upload_pid"
                else
                    echo "Model ${model_name}-${config_name} has already been uploaded. Skipping."
                fi
            fi
        done
    fi
done

# Wait for all upload jobs to complete
for job in "${upload_jobs[@]}"; do
    wait $job
    echo "Upload job with PID $job completed"
done

echo "All fine-tuning and upload jobs completed."
