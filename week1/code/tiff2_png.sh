#!/bin/bash 
for filename in *.tiff
do
    echo "Converting $filename to PNG..."
    convert "$filename" "$(basename "$filename" .tif).png"
done