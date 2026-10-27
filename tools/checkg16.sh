#!/bin/bash

# Check for running g16 processes
if pgrep -x "g16" > /dev/null; then
   echo "g16 is still running."
else
	# check error files first
	echo "File(s) with Error Termination..."
	echo "========================================="
	grep -L "Normal termination" *.log
	echo
	
	# check normal files
	echo "File(s) with Normal Termination..."
	echo "========================================="
	grep -L "Error termination" *.log
	echo
	
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
	echo "Do you want to compress all .log files into logs.zip?"
	read -p "Enter y/n: " choice
	if [ "$choice" = "y" ]; then
    	zip logs.zip *.log
    	echo "Compression complete."
	fi
fi

echo
echo -e "script by\nF. Diengdoh,\nDepartment of Chemistry,\nSt. Anthony's College,\nShillong, India"
