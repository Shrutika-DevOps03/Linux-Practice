## Script 2 : File Validation

#!/bin/bash
#check if file exists and is readable

read -p "Enter file name: "  filename="$1"

# Check if argument provided

if [ -z "$filename" ]; then
       echo "Error: Please provide a filename"
        echo "Usage: $0 <filename>"
        exit 1
fi

# check if file exist

if [ ! -e "$filename" ]; then
	echo "Error: file '$filename' does not exist"
	exit 1
fi

# check if it's regular file

if [ ! -f "$filename" ]; then
	echo "Error: '$filename' is not a regular file"
	exit 1
fi

# check if readable

if [ ! -r "$filename" ]; then
	echo "Error: '$filename' is not readable"
	exit 1
fi

echo "File '$filename' exists and is readable"
echo "File size: $(wc -c < "$filename") bytes"
