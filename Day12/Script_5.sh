## Script 5 : Numder Range Validator

#!/bin/bash
# Validate number is in range

read -p "Enter a number between 1 and 100: " number

# check if number
if  [[ $number =~ ^[0-9]+$ ]]; then
	echo "Error: Please enter a valid number"
	exit 1
fi

# Check range
if [ $number -lt 1 ] || [ $number -gt 100 ]; then
	echo "Error: Numbers must be between 1 and 100"
	exit 1
fi

echo "Number $number is valid"

# Provide feedback

if [ $number -le 25 ]; then
	echo "    That's in first quarter"
elif [ $number -le 50 ]; then
	echo "    That's in second quarter"
elif [ $number -le 75 ]; then
	echo "    That's in third quarter"
else
	echo "    That's in fourth quarter"
fi
