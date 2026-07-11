# /// script
# requires-python = ">=3.9"
# dependencies = [
#     "pypdf>=4.0",
# ]
# ///
"""
Interactive tool to remove password protection from PDFs in the current folder.

- Lists every .pdf in the current directory as a numbered menu.
- You pick one (or multiple / all).
- Unprotected copies are written to ./unprotected/
- Files already processed (output already exists) are skipped automatically.

Usage:
    uv run remove_pdf_password.py
    (or: python remove_pdf_password.py, after `pip install pypdf`)
"""

import getpass
import sys
from pathlib import Path

from pypdf import PdfReader, PdfWriter

OUTPUT_DIR = Path("unprotected")


def list_pdfs() -> list[Path]:
    return sorted(Path(".").glob("*.pdf"))


def show_menu(pdfs: list[Path]) -> None:
    print("\nPDF files found in current folder:\n")
    for i, pdf in enumerate(pdfs, start=1):
        out_path = OUTPUT_DIR / pdf.name
        status = " (already processed)" if out_path.exists() else ""
        print(f"  {i}. {pdf.name}{status}")
    print(f"  {len(pdfs) + 1}. All (process every unprocessed file)")
    print("  0. Quit")


def prompt_selection(pdfs: list[Path]) -> list[Path]:
    while True:
        choice = input(
            f"\nSelect a file [1-{len(pdfs)}], "
            f"'{len(pdfs) + 1}' for all, comma-separated for multiple, or 0 to quit: "
        ).strip()

        if choice == "0":
            print("Bye!")
            sys.exit(0)

        if choice == str(len(pdfs) + 1):
            return pdfs

        try:
            indices = [int(x.strip()) for x in choice.split(",") if x.strip()]
            if all(1 <= i <= len(pdfs) for i in indices):
                return [pdfs[i - 1] for i in indices]
        except ValueError:
            pass

        print("Invalid selection, try again.")


def remove_password(input_path: Path, output_path: Path, password: str) -> bool:
    reader = PdfReader(str(input_path))

    if reader.is_encrypted:
        result = reader.decrypt(password)
        if result == 0:
            print(f"  ✗ Incorrect password for {input_path.name}, skipping.")
            return False
    else:
        print(f"  Note: {input_path.name} was not encrypted; copying as-is.")

    writer = PdfWriter()
    for page in reader.pages:
        writer.add_page(page)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, "wb") as f:
        writer.write(f)

    print(f"  ✓ Saved unprotected copy to {output_path}")
    return True


def main() -> None:
    pdfs = list_pdfs()
    if not pdfs:
        print("No PDF files found in the current folder.")
        return

    show_menu(pdfs)
    selected = prompt_selection(pdfs)

    to_process = []
    for pdf in selected:
        out_path = OUTPUT_DIR / pdf.name
        if out_path.exists():
            print(f"Skipping {pdf.name} (already processed).")
        else:
            to_process.append(pdf)

    if not to_process:
        print("Nothing to do — all selected files are already processed.")
        return

    for pdf in to_process:
        out_path = OUTPUT_DIR / pdf.name
        reader = PdfReader(str(pdf))
        if reader.is_encrypted:
            password = getpass.getpass(f"\nPassword for {pdf.name}: ")
        else:
            password = ""
        remove_password(pdf, out_path, password)

    print("\nAll done.")


if __name__ == "__main__":
    main()
