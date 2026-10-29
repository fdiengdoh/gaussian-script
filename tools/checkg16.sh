#!/bin/bash

# Check for running g16 processes
if pgrep -x "g16" > /dev/null; then
   echo "g16 is still running."
else
	#!/bin/bash

	# Enable nullglob so the array is empty if no .log files match
	shopt -s nullglob
	log_files=(*.log)
	shopt -u nullglob

	# Check if any log files were found
	if [ ${#log_files[@]} -eq 0 ]; then
		echo "No log files found."
		exit 1
	fi

	# Variables / arrays to store the categorized files
	normal_files=()
	error_files=()

	# Loop through each log file found and categorize them
	for LOGFILE in "${log_files[@]}"; do
		LAST_LINE=$(tail -n 1 "$LOGFILE")

		# Check if the last line contains the phrase
		if echo "$LAST_LINE" | grep -q "Normal termination"; then
			normal_files+=("$LOGFILE")
		else
			error_files+=("$LOGFILE")
		fi
	done

	# Print results in the requested format
	echo "File(s) with Error Termination..."
	echo "========================================="
	if [ ${#error_files[@]} -eq 0 ]; then
		echo "None"
	else
		for file in "${error_files[@]}"; do
			echo "$file"
		done
	fi

	echo ""

	echo "File(s) with Normal Termination..."
	echo "========================================="
	if [ ${#normal_files[@]} -eq 0 ]; then
		echo "None"
	else
		for file in "${normal_files[@]}"; do
			echo "$file"
		done
	fi
	
	# check imaginary frequencies
	echo "File(s) with Imaginary Frequencies..."
	echo "========================================="
	for log in *.log; do
    	if grep -q "Frequencies --" "$log"; then
        	freq_line=$(grep "Frequencies --" "$log")
        	freq_values=$(echo "$freq_line" | awk '{for(i=3;i<=NF   ;i++) print $i}')
        	for freq in $freq_values; do
            if (( $(echo "$freq < 0" | bc -l) )); then
                echo "$log has imaginary frequency: $freq"
                break
            fi
        	done
    	fi
	done

	echo
	echo "Check complete."
	echo "========================================="
	echo
	echo "Do you want to compress all .log files as a zip fille?"
	read -p "Enter y/n: " choice
	if [ "$choice" = "y" ]; then
		read -p "Enter archive filename [default: logs.zip]: " custom_name
		# Use custom_name if provided, otherwise default to logs.zip
    	zip_name="${custom_name:-logs.zip}"

		# Ensure it ends with .zip
    	[[ "$zip_name" != *.zip ]] && zip_name="${zip_name}.zip"
    	
		zip "$zip_name" *.{log,gjf}
    	echo "Compression complete: $zip_name"
	fi
fi

echo
echo -e "script by\nF. Diengdoh,\nDepartment of Chemistry,\nSt. Anthony's College,\nShillong, India"
