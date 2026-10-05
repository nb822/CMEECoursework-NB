#!/usr/bin/env bash
# Author: Nick Brown <nb822@ic.ac.uk>
# Script: tabtocsv.sh
# Desc: Converts a tab-delimited file to a comma-separated file
# Arguments: 1-> tab delimited file
# Date: October 2026

echo "Creating a comma-separated version of $1..."

cat $1 | tr "\t" "," > $1.csv

echo "Done!"

exit 0