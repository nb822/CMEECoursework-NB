#!/usr/bin/env bash
# Author: Nick Brown <nb822@ic.ac.uk>
# Script: csvtospace.sh
# Desc: Converts a comma-separated file to a space-separated file
# Arguments: 1-> comma delimited file
# Date: October 2026

#accept only one readable file as input
if [ $# -ne 1 ]; then
    echo "Invalid file number. Please provide a single tab-delimited file as input." >&2
    exit 1
fi

#check if the file is readable
if [ ! -r "$1" ]; then
    echo "File $1 is not readable.." >&2
    exit 2
fi

#checks if commas in file
if [ $(grep -o "," "$1" | wc -l) == 0 ]; then
    echo "No commas found in the file." >&2
    exit 2
fi


echo "Creating a space-separated version of $1..."

#means that the file path isn't pasted after ../results/ as would happen if $1 used after >
name=$(basename "$1")

#so that the file goes to a results folder relative to the input, not cd
dir=$(dirname "$1")

#mkdir only if doesn't exist
mkdir -p "$dir/../results"

cat "$1" | tr "," " " > "$dir/../results/$name.space"
printf 'Done! Created a space-separated version of %s\n' "$1"
