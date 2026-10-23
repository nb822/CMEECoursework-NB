#!/usr/bin/env bash
# Author: Nick Brown <nb822@ic.ac.uk>
# Script: run_get_TreeHeight.sh
# Desc: Calculate height using distance and angle. returning height as a new column in a csv
# Arguments: None
# Date: October 2026

#change current directory to file above location this file is stored (assuming file is stored in code, this should take the script to the project root)
cd "$(dirname "$0")/.."

Rscript code/get_TreeHeight.R data/trees.csv

set -e