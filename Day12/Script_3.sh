## Script 3: String Validation

#!/bin/bash
# Username validation

read -p "Enter  username: " username

# Check if empty

if [ -z "$username" ]; then
	echo "Error: Username cannot be empty"
	exit 1
fi

# check length (3-20 characters)

if [ ${#username} -lt 3 ] || [${#username} -gt 20 ]; then
	echo "Error: Username must be 3-20 characters"
	exit 1
fi

# check format (alphnumeric and underscore only)

if ! [[ $username =~ ^[a-zA-Z0-9_]+$ ]]; then
	echo "Error: Username can only contain letters, numbers, and underscore"
	exit 1
fi

# check if starts with letter

if ! [[ $username =~ ^[a-zA-Z] ]]; then
	echo "Error: Username must start with a letter"
	exit 1
fi

echo "Username '$username' is valid"

