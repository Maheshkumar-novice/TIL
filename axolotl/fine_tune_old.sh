#!/bin/bash
# The shebang line above specifies that this script should be executed by the Bash shell.

# This script automates the process of fine-tuning machine learning models and uploading them to Hugging Face.
# It processes multiple configuration files in parallel, runs fine-tuning for each, and uploads successful results.

# Function to run fine-tuning for a single configuration
run_fine_tuning() {
    # This function encapsulates the fine-tuning process for a single configuration.
    
    local config_path="$1"     # Store the path to the configuration file. Using local keeps the variable scoped to this function.
    local output_dir="$2"      # Store the directory path for the fine-tuned model output. Local scope prevents conflicts.
    shift 2                    # Remove the first two arguments from $@, leaving only additional args.
    local additional_args="$@" # Capture any remaining arguments. This allows flexible command-line options.

    mkdir -p $output_dir

    # Create a log file name based on the configuration file name
    local log_file="./$(basename "$config_path" .yml)_training.log"
    # We use the output directory and the config file name to create a unique log file name.

    echo "Starting fine-tuning for $config_path. Logs will be written to $log_file"
    # Print a status message. This helps track progress and informs about the log file location.
    
    # Run the fine-tuning command, redirect output to the log file, and check its exit status
    if accelerate launch -m axolotl.cli.train "$config_path" --output_dir "$output_dir" $additional_args > "$log_file" 2>&1; then
        # The if statement runs the command and checks its exit status in one step.
        # accelerate launch is used to utilize GPU acceleration for training.
        # -m axolotl.cli.train specifies the Python module to run.
        # "$config_path" and "$output_dir" are quoted to handle paths with spaces.
        # $additional_args is unquoted to allow word splitting for multiple arguments.
        # > "$log_file" redirects stdout to the log file.
        # 2>&1 redirects stderr to the same place as stdout (the log file).
        
        echo "Completed fine-tuning for $config_path. Full logs available in $log_file"
        # Print a success message. This confirms the fine-tuning completed successfully and reminds about the log location.
        
        return 0  # Return success status. In Bash, 0 indicates success.
    else
        echo "Fine-tuning failed for $config_path. Check logs in $log_file for details."
        # Print a failure message. This alerts the user to the failure and points to the logs for troubleshooting.
        
        return 0  # Return failure status. In Bash, non-zero values indicate failure.
    fi
    # The if-else structure ensures we handle both success and failure cases.
}

# Function to merge and upload a model to Hugging Face
upload_to_hf() {
    local config_path="$1"  # Path to the configuration file
    local output_dir="$2"   # Directory containing the fine-tuned model
    local repo_name="$3"    # Name of the Hugging Face repository

    echo "Merging model from $output_dir and uploading to Hugging Face as $repo_name"

    # Create a log file name based on the configuration file name
    local log_file="./$(basename "$config_path" .yml)_merge.log"
    # We use the output directory and the config file name to create a unique log file name.

    # Create a directory for the merged model
    local merged_model_dir="${output_dir}/merged_model"
    mkdir -p "$merged_model_dir"

    # Merge the model using Axolotl
    if python3 -m axolotl.cli.merge_lora "$config_path" \
        --lora_model_dir "$output_dir" \
        --output_dir "$merged_model_dir" > $log_file 2>&1; then
        
        echo "Model merged successfully. Proceeding with upload."

        # Attempt to upload the merged model
        if huggingface-cli upload "$repo_name" "$merged_model_dir" --repo-type model --private; then
            echo "Uploaded merged model $repo_name to Hugging Face"
            rm -rf $output_dir
            return 0
        else
            echo "Failed to upload merged model $repo_name to Hugging Face"
            return 1
        fi
    else
        # REMOVE THIS
        # Attempt to upload the merged model
        if huggingface-cli upload "$repo_name" "$merged_model_dir" --repo-type model --private; then
            echo "Uploaded merged model $repo_name to Hugging Face"
            rm -rf $output_dir
            return 0
        else
            echo "Failed to upload merged model $repo_name to Hugging Face"
            return 1
        fi
        echo "Failed to merge model. Check logs in ${output_dir}/merge.log for details."
        return 1
    fi
}

# Function to run multiple jobs in parallel
run_parallel() {
    # This function manages running multiple jobs in parallel, up to a specified maximum.
    
    local max_jobs="$1"  # Store the maximum number of parallel jobs. Local scope for clarity.
    shift                # Remove the first argument (max_jobs) from $@.
    local jobs=()        # Initialize an empty array to store job PIDs. Local scope prevents conflicts.

    for job in "$@"; do
        # Iterate over each job passed to the function. "$@" expands to all arguments.
        
        # If we're at max jobs, wait for one to finish
        while (( ${#jobs[@]} >= max_jobs )); do
            # Check if the number of jobs is at or exceeds the maximum.
            # ${#jobs[@]} gets the length of the jobs array.
            
            for i in "${!jobs[@]}"; do
                # Iterate over indices of the jobs array. "${!jobs[@]}" expands to all array indices.
                
                if ! kill -0 ${jobs[$i]} 2>/dev/null; then
                    # Check if the job is still running. kill -0 checks process existence without sending a signal.
                    # 2>/dev/null redirects stderr to /dev/null to suppress error messages.
                    
                    unset jobs[$i]  # Remove finished job from array. unset removes the array element.
                    break  # Exit the inner loop once we've removed a finished job.
                fi
            done
            sleep 1  # Wait a second before checking again. This prevents excessive CPU usage in the loop.
        done

        # Start the job and store its PID
        eval "$job" &
        # eval executes the job command. & runs it in the background.
        
        jobs+=($!)  # Add new job PID to array. $! contains the PID of the last background process.
    done

    # Wait for all remaining jobs to finish
    for job in "${jobs[@]}"; do
        # Iterate over all jobs in the array. "${jobs[@]}" expands to all array elements.
        
        wait $job
        # wait suspends execution until the specified job completes.
    done
}

# Main script execution starts here

# Set the base directory for all models
models_folder="./models"
# Define the root folder where all model configurations are stored. Adjust this path as needed.

# Set the maximum number of parallel jobs (adjust based on system capabilities)
max_parallel_jobs=7
# Limit concurrent jobs to prevent system overload. Adjust based on available resources.

# Set your Hugging Face username (replace with actual username)
hf_username="<hf>"
# Specify the Hugging Face username for uploading models. Replace with the actual username.

# Array to store all commands to be executed
commands=()
# Initialize an empty array to store fine-tuning and upload commands for each configuration.

# Iterate through each model folder
for model_folder in "$models_folder"/*; do
    # Loop through all subdirectories in the models folder.
    
    if [ -d "$model_folder" ]; then
        # Check if the current item is a directory. This filters out non-directory items.
        
        model_name=$(basename "$model_folder")
        # Extract the model name from the folder path. basename returns the last part of the path.
        
        # Find all configuration files in the model folder
        for config_file in "$model_folder"/config_*.yml; do
            # Loop through all YAML config files in the current model folder.
            
            if [ -f "$config_file" ]; then
                # Check if the config file exists. This guards against errors if no matching files are found.
                
                # Extract the configuration file name without extension
                config_name=$(basename "$config_file" .yml)
                # Get the config file name without the path or .yml extension.
                
                # Create output directory for this configuration
                output_dir="$model_folder/output_$config_name"
                # Define the output directory for this specific configuration.
                
                # Prepare the command for running fine-tuning and uploading
                # This command will run fine-tuning and only upload if it succeeds
                command="if run_fine_tuning '$config_file' '$output_dir' $@; then "
                # Start building the command string. The if statement ensures upload only happens after successful fine-tuning.
                
                command+="upload_to_hf '$config_file' '$output_dir' '$hf_username/${model_name}-${config_name}'; "
                # Append the upload command to the command string. This will only execute if fine-tuning succeeds.
                
                command+="fi"
                # Close the if statement in the command string.
                
                commands+=("$command")
                # Add the complete command string to the commands array.
            fi
        done
    fi
done

# Run all fine-tuning jobs in parallel
run_parallel $max_parallel_jobs "${commands[@]}"
# Execute the run_parallel function with the maximum job limit and all prepared commands.

echo "All fine-tuning and upload jobs completed."
# Print a final status message indicating that all jobs have finished.
