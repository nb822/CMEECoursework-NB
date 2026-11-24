#!/usr/bin/env bash
# Author: Nick Brown <nb822@ic.ac.uk>
# Script: csvtospace.sh
# Desc: Converts a comma-separated file to a space-separated file
# Arguments: 1-> comma delimited file
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

#checks if commas in file
if [ $(grep -o "," "$1" | wc -l) == 0 ]; then
    echo "No commas found in the file." >&2
    exit 3
fi


echo "Creating a space-separated version of $1..."

#means that the file path isn't pasted after ../results/ as would happen if $1 used after >
name=$(basename "$1")

#mkdir only if doesn't exist
if ! mkdir -p data/; then
    echo "Error, could not make results directory" >&2
    exit 4
fi

cat "$1" | tr "," " " > "results/$name.txt"
printf 'Done! Created a space-separated version of %s\n' "$1"
exit 0

