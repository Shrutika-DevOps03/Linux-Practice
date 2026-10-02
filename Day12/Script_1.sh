## Script_1 : Age Validation

#!/bin/bash
# Simple age validator

read -p "Enter your age: " age

# Check if input is number

#if ! [[ $age =~ ^[0-9]+$ ]]; then
#echo "Error: Please enter a valid number"
#	exit 1
#fi

# Check age range

if [ $age -lt 0 ]; then
	echo "Error: Age cannot be negative"
	exit 1
elif [ $age -lt 13 ]; then
	echo "You are a child"
elif [ $age -lt 18 ]; then
	echo "You are a teenager"
elif [ $age -lt 65 ]; then
	echo "You are an adult"
else
	echo "You are a senior"
fi
