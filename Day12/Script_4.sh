## Script 4: Login Validator

#!/bin/bash
# Simple Login Validation

read -p "Enter username: " username
read -p "Enter Password: " password
echo
	VALID_USER="admin"
	VALID_PASS="password123"

#check if empty
if [ -z "$username" ] || [ -z "$password" ]; then
	echo "Error: Username and Password is empty"
	exit 1
fi

# check Credentials
if [ "$username" = "$VALID_USER" ] && [ "$password" = "$VALID_PASS" ]; then
	echo "Login successful!"
	echo "Welcome, $username"
else
	echo "Invalid username or password"
	exit 1
fi
