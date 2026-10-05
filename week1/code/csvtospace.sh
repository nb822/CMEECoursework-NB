#!/usr/bin/env bash
# Author: Nick Brown <nb822@ic.ac.uk>
# Script: csvtospace.sh
# Desc: Converts a comma-separated file to a space-separated file
# Arguments: 1-> comma delimited file
# Date: October 2026

echo "Creating a comma-separated version of $1..."

if [ $# -ne 1 ]; then
    echo "No input file provided."
    exit 1
fi

if [ $(grep -o "," $1 | wc -l) == 0 ]; then
    echo "No commas found in the file." >&2
    exit 2
fi

cat $1 | tr "," " " > $1.space
printf 'Done! Created a space-separated version of %s\n' "$1"
