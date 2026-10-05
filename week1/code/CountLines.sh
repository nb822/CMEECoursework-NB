#!/usr/bin/env bash
## < connects the named file to a standard input. Means the file name isn't printed twice
NumLines=`wc -l < "$1"`
echo "The file $1 has $NumLines lines."
echo