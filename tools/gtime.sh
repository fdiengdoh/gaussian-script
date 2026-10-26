#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <gaussian_log_file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found."
    exit 1
fi

echo "================================"
echo "  Gaussian 16 Runtime Analysis  "
echo "  File Name: $LOG_FILE"
echo "================================"
echo ""

# 1. Print all individual elapsed and CPU times side-by-side
echo "Breakdown of Individual Links"
paste <(grep "Elapsed time:" "$LOG_FILE") <(grep "Job cpu time:" "$LOG_FILE") | awk '
{
    print ""
    print "Link " NR ":"
    print "Elapsed time: " $3 "d " $5 "h " $7 "m " $9 "s"
    print "CPU time:     " $14 "d " $16 "h " $18 "m " $20 "s"
}'

echo ""
echo "--- Summary ---"

# 2. Get Raw Wall Seconds (Elapsed time uses columns 3, 5, 7, 9)
WALL_SECS=$(grep "Elapsed time:" "$LOG_FILE" | awk '{total += ($3 * 86400) + ($5 * 3600) + ($7 * 60) + $9} END {print total}')

# 3. Get Raw CPU Seconds (Job cpu time uses columns 4, 6, 8, 10)
CPU_SECS=$(grep "Job cpu time:" "$LOG_FILE" | awk '{total += ($4 * 86400) + ($6 * 3600) + ($8 * 60) + $10} END {print total}')

# 4. Format and display Total Elapsed Time
if [ -n "$WALL_SECS" ] && [ "$WALL_SECS" != "0" ]; then
    awk -v secs="$WALL_SECS" 'BEGIN {
        days = int(secs / 86400); rem = secs % 86400
        hours = int(rem / 3600); rem = rem % 3600
        mins = int(rem / 60); s = rem % 60
        print "Total Elaspsed Time:"
        printf "%dd, %dh, %dm, %.1fs\n", days, hours, mins, s
    }'
else
    echo "Total Elapsed Time: Not found"
fi
echo ""
# 5. Format and display Total CPU Time
if [ -n "$CPU_SECS" ] && [ "$CPU_SECS" != "0" ]; then
    awk -v secs="$CPU_SECS" 'BEGIN {
        days = int(secs / 86400); rem = secs % 86400
        hours = int(rem / 3600); rem = rem % 3600
        mins = int(rem / 60); s = rem % 60
        print "Total CPU Time:"
        printf "%dd, %dh, %dm, %.1fs\n", days, hours, mins, s
    }'
else
    echo "Total CPU Time: Not found"
fi
echo -e "\n\nscript by\nF. Diengdoh,\nDepartment of Chemistry,\nSt. Anthony's College,\nShillong, India"

echo "================================"
