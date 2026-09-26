## READ Command Basics

# Basic read
read variable_name                # Read input from user, store in variable

# Read with prompt
read -p "Enter your name: " name  # -p option shows prompt
echo "Hello, $name"

# Read with timeout
read -t 5 answer                  # Wait 5 seconds for input
echo "You entered: $answer"

# Read silently (for passwords)
read -s -p "Password: " password  # -s option hides input

# Read into variable from user input
read -p "Continue? (yes/no): " response
if [ "$response" = "yes" ]; then
    echo "Continuing..."
else
    echo "Canceled."
fi

->
Enter your name: Shrutika
Hello, Shrutika
UserInput.sh: 11: read: Illegal option -t
You entered:
UserInput.sh: 15: read: Illegal option -s
Continue? (yes/no): yes
Continuing...
