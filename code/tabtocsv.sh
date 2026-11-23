#!/usr/bin/env bash
# Author: Nick Brown <nb822@ic.ac.uk>
# Script: tabtocsv.sh
# Desc: Converts a tab-delimited file to a comma-separated file
# Arguments: 1-> tab delimited file
# Date: November 2026


#accept only one readable file as input
if [ $# -ne 1 ]; then
    echo "Invalid file number. Please provide a single tab-delimited file as input." >&2
    exit 1
fi

#check if the file is readable
if [ ! -r "$1" ] || [ ! -f "$1" ]; then
    echo "File $1 is not a readable file" >&2
    exit 2
fi

echo "Creating a comma delimited version of $1 ..."

#means that the file path isn't pasted after ../results/ as would happen if $1 used after >
name=$(basename "$1")

#make a results directory if it is needed
if ! mkdir -p data/; then
    echo "Error, could not make results directory" >&2
    exit 3
fi

#made files with spaces readable by quoting the variable
#preserved empty fields by removing -s
cat "$1" | tr "\t" "," > "results/$name.csv"

echo "Done!"

exit 0
