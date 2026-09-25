# Day 6: Master Bash Scripting Basics

**Time Spent:** 1 hr
**Difficulty:** Beginner 

## Today's Learning
- Write your first bash script (hello world)
- Learn variables and how to use them
- Learn `echo` command for output
- Add comments to scripts with `#`
- Make scripts executable with `chmod +x`
- Run scripts from command line
- Understanding shebang (`#!/bin/bash`)

## Understanding Bash Scripts

### What is a Bash Script?
A bash script is a text file containing shell commands that execute one after another. 
Instead of typing commands individually, you write them in a file and run them all at once.

```
Benefits:
- Automate repetitive tasks
- Run multiple commands in sequence
- Reuse code and workflows
- Schedule with cron jobs
```

## Your First Bash Script

### 1. CREATE HELLO WORLD SCRIPT
```bash
# Step 1: Create a new file
nano hello.sh
# or
vi hello.sh

# Step 2: Type the following content:
#!/bin/bash
# This is my first bash script

echo "Hello, World!"

# Step 3: Save and exit (nano: Ctrl+X, then Y, then Enter)
```

### 2. MAKE SCRIPT EXECUTABLE
```bash
chmod +x hello.sh
# Now the file has execute permission
```

### 3. RUN YOUR SCRIPT
```bash
# Method 1: Direct execution (requires +x permission)
./hello.sh

# Method 2: Using bash command (doesn't require +x)
bash hello.sh

# Method 3: Using sh command (doesn't require +x)
sh hello.sh
```

## Understanding Script Components

### SHEBANG Line (#!/bin/bash)
```bash
#!/bin/bash
# This line tells the system to use bash interpreter
# Must be on the first line
# The #! is called "shebang" or "hashbang"

# Other shebangs:
#!/bin/sh         # Standard shell (more portable)
#!/usr/bin/perl   # Perl script
#!/usr/bin/python # Python script
```

### COMMENTS
```bash
#!/bin/bash
# This is a comment - starts with #
# Comments explain what the code does
# They are ignored when the script runs

echo "This line executes"
# echo "This line does NOT execute (it's a comment)"

# Best practices for comments:
# 1. Comment what WHY, not what (the code shows what)
# 2. Use comments for non-obvious logic
# 3. Add comments at top explaining script purpose
# 4. Comment sections of larger scripts
```

### ECHO - Output Text
```bash
# Basic echo
echo "Hello, World!"              # Prints: Hello, World!
echo "This is a test"             # Prints: This is a test

# Echo with variables (covered below)
echo "Hello, $name"               # Prints: Hello, [value of name]

# Echo options
echo -n "Hello"                   # -n: no newline at end
echo -e "Line 1\nLine 2"          # -e: enable backslash escapes
echo -e "Tab\there"               # \t: tab character
echo -e "New\nLine"               # \n: newline

# Multiple echoes
echo "First line"
echo "Second line"                # Each echo creates new line

# Echo with quotes
echo 'Single quotes'              # Treats literally
echo "Double quotes"              # Allows variable expansion
echo `command`                    # Backticks execute command
```

### VARIABLES - Store Data
```bash
# Variable syntax:
variable_name=value

# Creating variables
name="Alice"                      # String variable
age=25                            # Number variable
greeting="Hello, World"           # String with spaces (needs quotes)

# Using variables
echo $name                        # Print variable (use $)
echo "$name is $age years old"   # Multiple variables
echo 'Name: $name'                # Single quotes: $name not expanded

# Variable naming rules:
# - Start with letter or underscore
# - Can contain letters, numbers, underscores
# - No spaces around = sign: name="value" (correct)
# - Not: name = "value" (wrong - spaces matter!)
# - Not: name="value with spaces" without quotes (wrong)

# Common variables
file="document.txt"
path="/home/user/documents"
status="complete"
count=42

# Variable with command output
current_date=$(date)              # Store command output
echo "Today is: $current_date"
```

## Commands to Practice

### Simple Script Examples

#### Example 1: Basic Hello Script
```bash
#!/bin/bash
# Simple hello world script

echo "Hello, World!"
```

#### Example 2: Script with Variables
```bash
#!/bin/bash
# Script that uses variables

name="Alice"
age=25
city="New York"

echo "My name is $name"
echo "I am $age years old"
echo "I live in $city"
```

#### Example 3: Script with Multiple Commands
```bash
#!/bin/bash
# Script demonstrating multiple commands

echo "=== System Information ==="
echo "Current date:"
date
echo ""
echo "Current user:"
whoami
echo ""
echo "Current directory:"
pwd
```

#### Example 4: Script with Comments
```bash
#!/bin/bash
# Purpose: Display user information
# Author: Your Name
# Date: Sept 20, 2026

# Set user variables
username="john"
userid=1000
usergroup="users"

# Display information
echo "Username: $username"
echo "User ID: $userid"
echo "User Group: $usergroup"

# Display system info
echo "System uptime:"
uptime
```

#### Example 5: Script with Comments and Variables
```bash
#!/bin/bash
# Welcome script that greets user by name
# Usage: ./welcome.sh

# Set variables
greeting="Welcome to Bash Scripting!"
user_name="Sarah"
favorite_language="Bash"

# Print greeting
echo "=========================================="
echo "$greeting"
echo "=========================================="
echo ""
echo "Hello, $user_name!"
echo "You are learning $favorite_language"
echo ""
echo "Good luck with your scripting journey!"
```

## Practice Commands

### Step-by-Step Practice

#### Practice 1: Create and Run Hello World
```bash
# Create directory for practice
mkdir -p ~/bash_scripts
cd ~/bash_scripts

# Create hello.sh
cat > hello.sh << 'EOF'
#!/bin/bash
echo "Hello, World!"
EOF

# View the file
cat hello.sh

# Make it executable
chmod +x hello.sh

# Run it
./hello.sh

# Check permissions
ls -l hello.sh
# You should see: -rwxr-xr-x (executable)
```

#### Practice 2: Script with Variables
```bash
# Create script with variables
cat > variables.sh << 'EOF'
#!/bin/bash
# Script demonstrating variables

name="Your Name"
age=30
hobby="programming"

echo "Hello, I am $name"
echo "I am $age years old"
echo "My hobby is $hobby"
EOF

# Make executable and run
chmod +x variables.sh
./variables.sh
```

#### Practice 3: Script with Multiple Commands
```bash
# Create system info script
cat > system_info.sh << 'EOF'
#!/bin/bash
# Display system information

echo "=== SYSTEM INFORMATION ==="
echo ""
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "Current Date: $(date)"
echo "Current Directory: $(pwd)"
echo "Disk Usage:"
df -h | head -2
EOF

chmod +x system_info.sh
./system_info.sh
```

#### Practice 4: Script with Comments
```bash
# Create well-commented script
cat > commented_script.sh << 'EOF'
#!/bin/bash
# Script: Weather Report Simulator
# Purpose: Display mock weather information
# Date: Sept 20, 2026

# Set location variable
location="Pune"

# Set temperature variable (in Celsius)
temperature=28

# Set weather condition
weather="Sunny"

# Print header
echo "========== WEATHER REPORT =========="

# Print location
echo "Location: $location"

# Print temperature
echo "Temperature: ${temperature}°C"

# Print condition
echo "Condition: $weather"

# Print footer
echo "===================================="
EOF

chmod +x commented_script.sh
./commented_script.sh
```

## Understanding Script Execution

### Method 1: Direct Execution (with shebang)
```bash
chmod +x script.sh    # Make executable
./script.sh           # Run from current directory
/path/to/script.sh    # Run with full path
~/script.sh           # Run from home directory
```

### Method 2: Bash Execution (without chmod)
```bash
bash script.sh        # Doesn't need execute permission
bash ~/script.sh      # Can run from any directory
bash /path/to/script.sh
```

### Method 3: Source/Execute
```bash
source script.sh      # Runs in current shell
. script.sh           # Dot notation (same as source)
```

## Understanding Permissions for Scripts

```bash
# Regular file (no execute permission)
-rw-r--r-- file.sh

# Executable script (has +x permission)
-rwxr-xr-x script.sh

# Make executable
chmod +x script.sh
chmod 755 script.sh   # Numeric form

# Check if file is executable
ls -l script.sh       # Look for 'x' in permissions
test -x script.sh && echo "Executable" || echo "Not executable"
```

## Key Takeaways

**Script Basics:**
- Shebang line (`#!/bin/bash`) must be first line
- Make executable with `chmod +x`
- Comments start with `#` (ignored by interpreter)
- Use `echo` to print output
- Variables store values using `name=value`
- Access variables with `$name`

**Variable Rules:**
- No spaces around `=`: `name="value"` not `name = "value"`
- Use quotes for strings with spaces
- Use `$` when accessing variable
- Single quotes prevent expansion
- Double quotes allow variable expansion

**Running Scripts:**
1. `./script.sh` - Direct execution (needs +x permission)
2. `bash script.sh` - Via bash interpreter (no +x needed)
3. `source script.sh` - Run in current shell

**Comments Best Practices:**
- Explain WHY, not WHAT
- Add header comment explaining script purpose
- Comment complex logic
- Use descriptive variable names to reduce comments

## Safe Practice Steps
1. Create practice directory: `mkdir ~/bash_scripts`
2. Create hello.sh with shebang and echo
3. Make executable: `chmod +x hello.sh`
4. Run it: `./hello.sh`
5. Add variables: `name="value"`
6. Use variables: `echo $name`
7. Add comments: `# This is a comment`
8. View permissions: `ls -l hello.sh`
9. Practice with different echo options
10. Create multiple scripts with different variables

## Resources to Use
- Bash manual: `man bash`
- Google "bash script examples"
- Bash scripting tutorials online
- Practice by writing simple scripts

## Common Script Structure

```bash
#!/bin/bash
# Purpose: Brief description of what script does
# Author: Your name
# Date: Today's date
# Usage: ./script.sh

# ===== VARIABLES =====
variable1="value1"
variable2="value2"

# ===== FUNCTIONS =====
# (We'll learn this later)

# ===== MAIN SCRIPT =====
echo "Script is running"
echo "Variable1: $variable1"
echo "Variable2: $variable2"

# ===== END =====
```

## Struggle Points
- Space around the = sign in variable assignment.

## Common Beginner Mistakes

```bash
# WRONG: Space around =
name = "Alice"                    # Error!

# CORRECT: No spaces
name="Alice"                      # Good!

# WRONG: Forgetting $ to access variable
echo name                         # Prints: name (not the value)

# CORRECT: Using $ to access
echo $name                        # Prints: Alice

# WRONG: Single quotes prevent expansion
echo 'My name is $name'           # Prints: My name is $name

# CORRECT: Double quotes allow expansion
echo "My name is $name"           # Prints: My name is Alice

# WRONG: Script not executable
./script.sh                       # Permission denied

# CORRECT: Make executable first
chmod +x script.sh
./script.sh                       # Works!

# WRONG: Wrong shebang
#!/bin/bash                       # Correct
#! /bin/bash                      # Wrong (space after #!)
# !/bin/bash                      # Wrong (space before #!)
```

## Notes
- Always use `#!/bin/bash` as first line in scripts
- Use descriptive variable names: `user_name` not `un`
- Comment your code for future you and others
- Test scripts before running on important data
- Use quotes around variables: `echo "$name"` is safer
- Don't run scripts from unknown sources
- Make backups before automating file operations
- Build scripts incrementally - test each part
- Keep scripts in a dedicated directory like ~/bash_scripts
- Start simple and add complexity gradually
