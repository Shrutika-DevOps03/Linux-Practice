# Day 12: Master Bash Conditional Statements (if-else)

**Time Spent:** 1 hr 
**Difficulty:** Intermediate

## Today's Learning
- Write if-else statements
- Understand test operators: `[ ]` and `[[ ]]`
- Compare numbers (numeric comparisons)
- Compare strings (string comparisons)
- Use logical operators (AND, OR, NOT)
- Create validation scripts
- Handle multiple conditions
- Write scripts that make decisions

## Understanding Conditional Statements

### Basic IF Statement Structure
```bash
# Simple if
if [ condition ]; then
    # Commands if condition is true
fi

# If-else
if [ condition ]; then
    # Commands if true
else
    # Commands if false
fi

# If-elif-else
if [ condition1 ]; then
    # If condition1 true
elif [ condition2 ]; then
    # If condition2 true
else
    # If neither true
fi
```

## Test Operators: [ ] vs [[ ]]

### Difference Between [ ] and [[ ]]
```bash
# [ ] - POSIX test (works everywhere, stricter)
if [ condition ]; then
    echo "Using POSIX test"
fi

# [[ ]] - Bash extended test (more flexible, bash-specific)
if [[ condition ]]; then
    echo "Using bash test"
fi

# Practical difference
var="test value"

# [ ] requires proper quoting
if [ "$var" = "test value" ]; then    # Must quote variable
    echo "Matched"
fi

# [[ ]] more forgiving with quoting
if [[ $var = "test value" ]]; then    # Quotes optional
    echo "Matched"
fi

# [[ ]] supports regex
if [[ $var =~ ^test ]]; then          # Regex pattern
    echo "Starts with test"
fi
```

## Numeric Comparisons

### Numeric Test Operators
```bash
# Number comparison (use these with [ ] and [[ ]])
-eq   # equal to
-ne   # not equal to
-lt   # less than
-le   # less than or equal to
-gt   # greater than
-ge   # greater than or equal to
```

### Numeric Comparison Examples
```bash
#!/bin/bash

age=25

# Equal
if [ $age -eq 25 ]; then
    echo "Age is 25"
fi

# Not equal
if [ $age -ne 30 ]; then
    echo "Age is not 30"
fi

# Less than
if [ $age -lt 30 ]; then
    echo "Age is less than 30"
fi

# Greater than
if [ $age -gt 18 ]; then
    echo "Age is greater than 18"
fi

# Less than or equal
if [ $age -le 25 ]; then
    echo "Age is 25 or less"
fi

# Greater than or equal
if [ $age -ge 18 ]; then
    echo "Age is 18 or older"
fi

# Multiple conditions (AND - both must be true)
if [ $age -gt 18 ] && [ $age -lt 65 ]; then
    echo "Working age"
fi

# Multiple conditions (OR - at least one must be true)
if [ $age -lt 13 ] || [ $age -gt 65 ]; then
    echo "Not working age"
fi
```

## String Comparisons

### String Test Operators
```bash
=     # equal to
!=    # not equal to
-z    # string is empty (zero length)
-n    # string is not empty
=~    # matches regex (bash only, use [[ ]])
```

### String Comparison Examples
```bash
#!/bin/bash

name="Alice"
city="New York"
input=""

# String equals
if [ "$name" = "Alice" ]; then
    echo "Hello Alice"
fi

# String not equals
if [ "$name" != "Bob" ]; then
    echo "You are not Bob"
fi

# String is empty
if [ -z "$input" ]; then
    echo "Input is empty"
fi

# String is not empty
if [ -n "$name" ]; then
    echo "Name is not empty: $name"
fi

# Case-insensitive (convert to lowercase)
if [[ "${name,,}" = "alice" ]]; then
    echo "Name is alice (case-insensitive)"
fi

# String contains substring
if [[ "$city" == *"York"* ]]; then
    echo "City contains York"
fi

# Regex match (bash only)
if [[ "$name" =~ ^[A-Z] ]]; then
    echo "Name starts with uppercase letter"
fi

# Multiple string conditions (AND)
if [ "$name" = "Alice" ] && [ "$city" = "New York" ]; then
    echo "Alice from New York found"
fi

# Multiple string conditions (OR)
if [ "$name" = "Alice" ] || [ "$name" = "Bob" ]; then
    echo "Found Alice or Bob"
fi
```

## File Tests

### File Test Operators
```bash
-f file      # file exists and is regular file
-d dir       # directory exists
-e path      # file or directory exists
-r file      # file exists and is readable
-w file      # file exists and is writable
-x file      # file exists and is executable
-s file      # file exists and is not empty
-z file      # file is empty
```

### File Test Examples
```bash
#!/bin/bash

# Check if file exists
if [ -f "config.txt" ]; then
    echo "Config file exists"
fi

# Check if directory exists
if [ -d "/home/user" ]; then
    echo "Home directory exists"
fi

# Check if readable
if [ -r "file.txt" ]; then
    echo "File is readable"
fi

# Check if writable
if [ -w "file.txt" ]; then
    echo "File is writable"
fi

# Check if executable
if [ -x "script.sh" ]; then
    echo "Script is executable"
fi

# Check if not empty
if [ -s "file.txt" ]; then
    echo "File has content"
fi

# Check if empty
if [ ! -s "file.txt" ]; then
    echo "File is empty"
fi
```

## Logical Operators

### AND, OR, NOT Logic
```bash
#!/bin/bash

age=25
name="Alice"

# AND - both conditions must be true
if [ $age -gt 18 ] && [ "$name" = "Alice" ]; then
    echo "Alice is adult"
fi

# OR - at least one must be true
if [ $age -lt 13 ] || [ $age -gt 65 ]; then
    echo "Not in working age"
fi

# NOT - inverse the condition
if [ ! "$name" = "Bob" ]; then
    echo "You are not Bob"
fi

# NOT with file test
if [ ! -f "config.txt" ]; then
    echo "Config file does not exist"
fi

# Complex combination
if [ $age -gt 18 ] && [ -f "license.txt" ] || [ "$name" = "Admin" ]; then
    echo "Access granted"
fi
```

## Practical Validation Scripts

### Script 1: Age Validation
```bash
#!/bin/bash
# Simple age validator

read -p "Enter your age: " age

# Check if input is a number
if ! [[ $age =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number"
    exit 1
fi

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
```

### Script 2: File Validator
```bash
#!/bin/bash
# Check if file exists and is readable

filename="$1"

# Check if argument provided
if [ -z "$filename" ]; then
    echo "Error: Please provide a filename"
    echo "Usage: $0 <filename>"
    exit 1
fi

# Check if file exists
if [ ! -e "$filename" ]; then
    echo "Error: File '$filename' does not exist"
    exit 1
fi

# Check if it's a regular file
if [ ! -f "$filename" ]; then
    echo "Error: '$filename' is not a regular file"
    exit 1
fi

# Check if readable
if [ ! -r "$filename" ]; then
    echo "Error: '$filename' is not readable"
    exit 1
fi

echo "✓ File '$filename' exists and is readable"
echo "File size: $(wc -c < "$filename") bytes"
```

### Script 3: String Validation
```bash
#!/bin/bash
# Username validator

read -p "Enter username: " username

# Check if empty
if [ -z "$username" ]; then
    echo "Error: Username cannot be empty"
    exit 1
fi

# Check length (3-20 characters)
if [ ${#username} -lt 3 ] || [ ${#username} -gt 20 ]; then
    echo "Error: Username must be 3-20 characters"
    exit 1
fi

# Check format (alphanumeric and underscore only)
if ! [[ $username =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "Error: Username can only contain letters, numbers, and underscore"
    exit 1
fi

# Check if starts with letter
if ! [[ $username =~ ^[a-zA-Z] ]]; then
    echo "Error: Username must start with a letter"
    exit 1
fi

echo "✓ Username '$username' is valid"
```

### Script 4: Login Validator
```bash
#!/bin/bash
# Simple login validation

read -p "Enter username: " username
read -sp "Enter password: " password
echo

# Hardcoded credentials (for demo only - NEVER do this in real scripts!)
VALID_USER="admin"
VALID_PASS="password123"

# Check if empty
if [ -z "$username" ] || [ -z "$password" ]; then
    echo "✗ Error: Username or password is empty"
    exit 1
fi

# Check credentials
if [ "$username" = "$VALID_USER" ] && [ "$password" = "$VALID_PASS" ]; then
    echo "✓ Login successful!"
    echo "Welcome, $username"
else
    echo "✗ Invalid username or password"
    exit 1
fi
```

### Script 5: Number Range Validator
```bash
#!/bin/bash
# Validate number is in range

read -p "Enter a number between 1 and 100: " number

# Check if number
if ! [[ $number =~ ^[0-9]+$ ]]; then
    echo "✗ Error: Please enter a valid number"
    exit 1
fi

# Check range
if [ $number -lt 1 ] || [ $number -gt 100 ]; then
    echo "✗ Error: Number must be between 1 and 100"
    exit 1
fi

echo "✓ Number $number is valid"

# Provide feedback
if [ $number -le 25 ]; then
    echo "   That's in the first quarter"
elif [ $number -le 50 ]; then
    echo "   That's in the second quarter"
elif [ $number -le 75 ]; then
    echo "   That's in the third quarter"
else
    echo "   That's in the fourth quarter"
fi
```

## Practice Commands

### Create Test Scripts
```bash
# Create age validator
cat > ~/age_validator.sh << 'EOF'
#!/bin/bash
read -p "Enter your age: " age

if ! [[ $age =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid age"
    exit 1
fi

if [ $age -lt 18 ]; then
    echo "You are a minor"
elif [ $age -lt 65 ]; then
    echo "You are an adult"
else
    echo "You are a senior"
fi
EOF

chmod +x ~/age_validator.sh
```

### Test Numeric Comparisons
```bash
# Create script
cat > ~/test_numbers.sh << 'EOF'
#!/bin/bash
a=10
b=20

if [ $a -lt $b ]; then
    echo "$a is less than $b"
fi

if [ $a -ne $b ]; then
    echo "$a is not equal to $b"
fi

if [ $a -gt 5 ] && [ $b -lt 30 ]; then
    echo "Both conditions are true"
fi
EOF

chmod +x ~/test_numbers.sh
./test_numbers.sh
```

### Test String Comparisons
```bash
# Create script
cat > ~/test_strings.sh << 'EOF'
#!/bin/bash
name="Alice"
city="London"

if [ "$name" = "Alice" ]; then
    echo "Name is Alice"
fi

if [ -n "$city" ]; then
    echo "City is not empty: $city"
fi

if [[ "$name" =~ ^A ]]; then
    echo "Name starts with A"
fi
EOF

chmod +x ~/test_strings.sh
./test_strings.sh
```

## Key Takeaways

**IF Statement Structure:**
```bash
if [ condition ]; then
    # code if true
elif [ condition2 ]; then
    # code if condition2 true
else
    # code if all false
fi
```

**Numeric Comparisons:**
- `-eq` equals, `-ne` not equals
- `-lt` less than, `-le` less or equal
- `-gt` greater than, `-ge` greater or equal

**String Comparisons:**
- `=` equals, `!=` not equals
- `-z` is empty, `-n` is not empty
- `=~` regex match (bash only)

**File Tests:**
- `-f` is file, `-d` is directory, `-e` exists
- `-r` readable, `-w` writable, `-x` executable
- `-s` not empty, `-z` is empty

**Logical Operators:**
- `&&` AND (both true), `||` OR (either true)
- `!` NOT (inverse condition)

**Test Operators:**
- `[ ]` POSIX test (portable, strict)
- `[[ ]]` Bash test (more flexible, supports regex)

## Safe Practice Steps
1. Write simple if statement: `if [ 5 -lt 10 ]; then echo "yes"; fi`
2. Test numeric comparison: `if [ $a -eq $b ]; then ... fi`
3. Test string comparison: `if [ "$name" = "value" ]; then ... fi`
4. Test file existence: `if [ -f file.txt ]; then ... fi`
5. Use AND operator: `if [ $a -gt 5 ] && [ $b -lt 10 ]; then ... fi`
6. Use OR operator: `if [ $a -eq 5 ] || [ $b -eq 5 ]; then ... fi`
7. Use NOT operator: `if [ ! -f file.txt ]; then ... fi`
8. Create age validator script
9. Create file validator script
10. Create login validator script

## Resources to Use
- Bash manual: `man test`, `man bash` (search "Conditional Expressions")
- Test operators documentation
- Practice with simple conditions first
- Build complexity gradually

## Common Mistakes

```bash
# WRONG: Space issues with operators
if [$x -eq 5]; then        # Missing space: [ $x
if [ $x -eq 5 ]then        # Missing space before then

# CORRECT: Proper spacing
if [ $x -eq 5 ]; then

# WRONG: Using = for numbers
if [ $age = 25 ]; then     # Wrong! = is for strings

# CORRECT: Using -eq for numbers
if [ $age -eq 25 ]; then

# WRONG: Not quoting variables with spaces
if [ $filename = "my file.txt" ]; then    # Fails if var has spaces

# CORRECT: Quote variables
if [ "$filename" = "my file.txt" ]; then

# WRONG: Using arithmetic instead of test
if [ $a + $b -gt 10 ]; then    # Won't work as expected

# CORRECT: Use arithmetic expansion
if (( a + b > 10 )); then      # Or use [ $((a + b)) -gt 10 ]
```

## Validation Script Checklist

When creating validation scripts:
- ✅ Check if input is empty
- ✅ Check if input is correct type (number, string, etc.)
- ✅ Check input length (if applicable)
- ✅ Check input format/pattern (if applicable)
- ✅ Check if file exists (if using files)
- ✅ Check if value in valid range (if applicable)
- ✅ Provide clear error messages
- ✅ Use `exit 1` on error
- ✅ Use `exit 0` on success

## Struggle Points
1. Space issues with operatore: Missing space before then
2. Using = for numbers instead of -eq
3. Not quoting variables with spaces

## Notes
- Always quote variables: `[ "$var" = "value" ]` not `[ $var = "value" ]`
- Use `-eq` for numbers, `=` for strings
- Use `[[ ]]` for bash scripts (more features), `[ ]` for portability
- Exit with non-zero on errors: `exit 1`
- Test one condition at a time first, then combine
- Use regex with `[[ ]]` and `=~` operator
- Remember: logical AND is `&&`, logical OR is `||`
- File tests are powerful for error checking
- Validation is critical for robust scripts
- Always handle edge cases (empty input, wrong type, etc.)
