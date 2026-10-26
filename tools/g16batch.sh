#!/bin/bash

# Check README before starting background execution
if [ ! -f README ]; then
    echo "ERROR: README file not found!"
    echo
    echo "Create a README file listing the Gaussian input files"
    echo "in the order you want them to run."
    echo
    echo "Example README:"
    echo "--------------------------------"
    echo "# Gaussian calculation sequence"
    echo "# Lines starting with # are ignored"
    echo "# Blank lines are also ignored"
    echo "# .gjf extension is optional"
    echo "file_b"
    echo ""
    echo "# Second calculation"
    echo "file_a.gjf"
    echo "file_c"
    echo "--------------------------------"
    exit 1
fi

# Automatically run in background
if [ "$1" != "--background" ]; then
    script_name=$(basename -- "$0")
    log_file="${script_name%.*}.txt"

    nohup "$0" --background >> "$log_file" 2>&1 &
    echo "Gaussian calculations started in background."
    echo "Output log: $log_file"
    echo "Monitor progress with: tail -f \"$log_file\""
    exit 0
fi

# Create completed folder
mkdir -p completed

while IFS= read -r line || [ -n "$line" ]; do
    # 1. Remove Windows carriage returns
    line=$(echo "$line" | tr -d '\r')

    # 2. Skip empty or whitespace-only lines (using your case method!)
    case "$line" in
        *[![:space:]]*) ;;
        *) continue ;;
    esac

    # Skip comment lines safely
    case "$line" in
        *[[:space:]]\#* | \#*) continue ;;
    esac

    # 4. Clean any accidental trailing/leading spaces from the filename string
    clean_line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # 5. Ensure the filename ends with .gjf
    case "$clean_line" in
        *.gjf) gjf="$clean_line" ;;
        *)     gjf="${clean_line}.gjf" ;;
    esac

    # Check if the file actually exists before running
    if [ ! -f "$gjf" ]; then
        echo "Warning: File '$gjf' listed in readme does not exist. Skipping..."
        continue
    fi

    # Check if the file actually exists before running
    if [ ! -f "$gjf" ]; then
        echo "Warning: File '$gjf' listed in readme does not exist. Skipping..."
        continue
    fi

    echo "========================================"
    echo "Running Gaussian for $gjf..."
    date

    g16 "$gjf"

    base="${gjf%.gjf}"

    # Check for normal Gaussian termination
    if grep -q "Normal termination of Gaussian" "$base.log" 2>/dev/null; then
        echo "Successfully completed: $gjf"

        # Move available files into completed/
        for ext in gjf log chk; do
            if [ -f "$base.$ext" ]; then
                mv -- "$base.$ext" completed/
            fi
        done

        echo "Files moved to completed/"
    else
        echo "WARNING: $gjf failed or did not terminate normally."
        echo "Files remain in the current folder."
    fi

    date

done < README

echo "All calculations in README have been processed."
echo -e "script by\nF. Diengdoh,\nDepartment of Chemistry,\nSt. Anthony's College,\nShillong, India"
