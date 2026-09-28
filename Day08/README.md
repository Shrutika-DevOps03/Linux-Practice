# Day 8: Master GREP - Text Search and Pattern Matching
 
**Time Spent:** 45 min
**Difficulty:** Beginner

## Today's Learning
- Learn `grep` command syntax and basics
- Use common flags: `-i`, `-v`, `-c`, `-n`, `-r`
- Search for patterns in files
- Understand regular expressions (regex)
- Search system logs for errors and warnings
- Combine `grep` with other commands
- Filter output efficiently

## Understanding GREP Basics

### What is GREP?
`grep` = "Global Regular Expression Print"

It searches for lines matching a pattern and prints them to output.

```
Basic Syntax: grep [options] "pattern" [file]
```

## GREP Command Fundamentals

### Basic GREP Usage
```bash
# Search for exact text in file
grep "error" file.txt             # Find lines containing "error"
grep "user" /etc/passwd           # Search passwd file for "user"

# Case-insensitive search
grep -i "ERROR" file.txt          # Find "ERROR", "error", "Error", etc.
grep -i "warning" log.txt         # Case-insensitive search

# Search multiple files
grep "pattern" file1.txt file2.txt  # Search two files
grep "pattern" *.txt              # Search all .txt files

# Search recursively in directories
grep -r "error" /var/log/         # Search all files in directory
grep -r "ERROR" .                 # Search current directory recursively
```

## Common GREP Flags

### -i (Ignore Case)
```bash
# Find pattern regardless of case
grep -i "error" file.txt          # Matches: error, ERROR, Error, eRrOr
grep -i "warning" log.txt         # Matches: warning, WARNING, Warning

# Real-world example
grep -i "failed" /var/log/syslog  # Find failed login attempts
```

### -v (Invert Match - Show lines WITHOUT pattern)
```bash
# Show lines that do NOT contain pattern
grep -v "error" file.txt          # Show all lines without "error"
grep -v "^#" config.conf          # Show config lines (skip comments)
grep -v "^$" file.txt             # Show non-empty lines (skip blank)

# Combine with other flags
grep -v -i "warning" file.txt     # Lines not containing "warning" (case-insensitive)
```

### -c (Count Matches)
```bash
# Count matching lines
grep -c "error" file.txt          # How many lines contain "error"?
grep -c "ERROR" /var/log/syslog   # Count ERROR messages
grep -i -c "warning" log.txt      # Count warnings (case-insensitive)

# Output example:
# 42 (means 42 lines contain "error")
```

### -n (Show Line Numbers)
```bash
# Display line numbers with matches
grep -n "error" file.txt          # Shows: 5:error message here
grep -n "ERROR" log.txt           # Line 10: ERROR occurred

# Useful for finding exact location in file
grep -n "pattern" file.txt        # Use line number to edit with nano
```

### -r or -R (Recursive Search)
```bash
# Search all files in directory and subdirectories
grep -r "error" /var/log/         # Search logs recursively
grep -r "TODO" /home/user/projects # Search all project files
grep -r "password" /etc/           # Search config files

# Combine options
grep -r -i "error" .              # Recursive, case-insensitive
grep -rn "pattern" /home/         # Recursive with line numbers
```

### Other Useful Flags
```bash
# -l: Show only filenames (not matching lines)
grep -l "error" *.log             # Which files contain "error"?

# -L: Show files that do NOT match
grep -L "error" *.log             # Which files have NO "error"?

# -w: Match whole words only
grep -w "cat" file.txt            # Find "cat" but not "catastrophe"
grep -w "error" log.txt           # Exact word "error" only

# -x: Match entire line
grep -x "error" file.txt          # Lines that are exactly "error"

# -A: Lines After match
grep -A 2 "error" file.txt        # Show match + 2 lines after
grep -A 5 "ERROR" log.txt         # Error line + 5 lines after (context)

# -B: Lines Before match
grep -B 2 "error" file.txt        # 2 lines before match
grep -B 3 "ERROR" log.txt         # 3 lines before error

# -C: Context (Before and After)
grep -C 3 "error" file.txt        # 3 lines before and after
grep -C 2 "pattern" log.txt       # 2 lines context on both sides
```

## Regular Expressions (REGEX)

### Basic Regular Expression Patterns
```bash
# Literal match
grep "error" file.txt             # Find "error" exactly

# . (dot) - Any single character
grep "e.ror" file.txt             # Matches: error, eXror, e9ror, etc.

# ^ (caret) - Start of line
grep "^error" file.txt            # Match only at start of line
grep "^[0-9]" file.txt            # Lines starting with number

# $ (dollar) - End of line
grep "error$" file.txt            # Match only at end of line
grep ".txt$" file.txt             # Lines ending with .txt

# * (asterisk) - Zero or more of previous character
grep "err*or" file.txt            # Matches: eror, error, errror, etc.

# [] (brackets) - Any one character inside
grep "[aeiou]" file.txt           # Lines containing vowels
grep "[0-9]" file.txt             # Lines containing digits
grep "[A-Z]" file.txt             # Lines with uppercase letters

# [^] (negation) - NOT these characters
grep "[^0-9]" file.txt            # Lines without digits
grep "[^aeiou]" file.txt          # Lines without vowels

# | (pipe) - OR pattern (extended regex)
grep -E "error|warning" file.txt  # Lines with "error" OR "warning"
grep -E "ERROR|WARN" log.txt      # Multiple patterns
```

### Extended Regular Expressions (-E flag)
```bash
# Extended regex features
grep -E "pattern1|pattern2" file  # OR logic

# + (one or more)
grep -E "err+or" file.txt         # error, errror, errrror, etc.

# ? (zero or one)
grep -E "colou?r" file.txt        # color or colour

# {} (exactly N times)
grep -E "[0-9]{3}" file.txt       # Exactly 3 digits
grep -E "[a-z]{2,4}" file.txt     # 2 to 4 letters

# () (grouping)
grep -E "(error|warning)" file    # Group patterns
```

### Useful Regex Patterns
```bash
# Email addresses
grep -E "[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+" file.txt

# IP addresses
grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" file.txt

# Phone numbers
grep -E "[0-9]{3}-[0-9]{3}-[0-9]{4}" file.txt

# URLs
grep -E "https?://" file.txt

# Log timestamps
grep -E "[0-9]{2}:[0-9]{2}:[0-9]{2}" log.txt
```

## Practical Examples

### Searching System Logs
```bash
# Find errors in syslog
grep "error" /var/log/syslog
grep -i "error" /var/log/syslog   # Case-insensitive

# Find specific service errors
grep "apache2" /var/log/syslog    # Apache errors
grep "kernel" /var/log/syslog     # Kernel messages

# Find errors with context
grep -B 2 -A 2 "ERROR" /var/log/syslog  # 2 lines before/after

# Count errors
grep -c "error" /var/log/syslog   # How many errors?

# Find recent errors (with date)
grep "error" /var/log/syslog | tail -10  # Last 10 errors

# Search multiple log files
grep "error" /var/log/syslog /var/log/auth.log

# Find failed login attempts
grep "Failed password" /var/log/auth.log
grep -i "failed" /var/log/auth.log

# Find SSH connection issues
grep "ssh" /var/log/auth.log
grep -E "Accepted|Failed" /var/log/auth.log  # Successful or failed logins
```

### Searching Source Code
```bash
# Find TODO comments
grep -n "TODO" *.py               # Line numbers helpful for editors

# Find all function calls
grep -n "def " script.py          # All function definitions

# Find imports in Python
grep "^import\|^from" script.py   # All imports

# Find configuration values
grep -n "DATABASE_" config.py     # Database settings

# Find specific pattern with context
grep -C 5 "critical" code.py      # Critical code section
```

### Searching Configuration Files
```bash
# Search configuration file
grep -v "^#" /etc/nginx/nginx.conf  # Skip comments
grep -v "^$" /etc/nginx/nginx.conf  # Skip blank lines
grep -v "^#\|^$" /etc/nginx/nginx.conf  # Skip both

# Find active settings
grep "listen\|server_name" /etc/nginx/nginx.conf

# Find enabled features
grep "enable\|enabled" /etc/mysql/mysql.conf.d/mysqld.cnf
```

### Combining GREP with Other Commands
```bash
# Pipe grep to other commands
cat file.txt | grep "error"       # Same as grep "error" file.txt

# Multiple greps (AND logic)
grep "error" file.txt | grep "database"  # Lines with both "error" AND "database"

# GREP with find
find /var/log -name "*.log" -exec grep "error" {} \;

# Count all errors across multiple files
grep -r "ERROR" /var/log | wc -l

# Show unique matches
grep "pattern" file.txt | sort | uniq

# Show top 10 errors
grep "error" /var/log/syslog | sort | uniq -c | sort -rn | head -10
```

## Practice Commands

### Create Test Environment
```bash
# Create test file with mixed content
cat > ~/test_log.txt << 'EOF'
2026-09-22 10:15:32 ERROR: Database connection failed
2026-09-22 10:15:45 WARNING: High memory usage detected
2026-09-22 10:16:10 INFO: User john logged in
2026-09-22 10:16:22 ERROR: File not found: /data/users.csv
2026-09-22 10:16:45 INFO: Backup started
2026-09-22 10:17:00 ERROR: Backup failed: Permission denied
2026-09-22 10:17:15 WARNING: Low disk space
2026-09-22 10:18:00 INFO: System check complete
2026-09-22 10:18:30 ERROR: Network timeout
EOF

cat > ~/config.txt << 'EOF'
# Database Configuration
# author: admin
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=myapp
# User Configuration
USER_ADMIN=true
USER_DEBUG=false
# Application Settings
APP_VERSION=2.1.0
EOF
```

### Basic Searches
```bash
# Find error lines
grep "ERROR" ~/test_log.txt

# Find warnings (case-insensitive)
grep -i "warning" ~/test_log.txt

# Count errors
grep -c "ERROR" ~/test_log.txt

# Show line numbers
grep -n "ERROR" ~/test_log.txt

# Find lines without "ERROR"
grep -v "ERROR" ~/test_log.txt

# Find non-comment lines in config
grep -v "^#" ~/config.txt

# Find configuration values
grep "^[A-Z]" ~/config.txt        # Lines starting with uppercase
```

### Advanced Searches
```bash
# Find ERROR with context
grep -B 1 -A 1 "ERROR" ~/test_log.txt

# Search case-insensitive with line numbers
grep -in "error" ~/test_log.txt

# Find multiple patterns
grep -E "ERROR|WARNING" ~/test_log.txt

# Find exact word
grep -w "ERROR" ~/test_log.txt

# Find lines starting with timestamp
grep "^2026-09-22 10:1[67]" ~/test_log.txt
```

### System Log Searches
```bash
# Real system logs (if available)
grep "error" /var/log/syslog 2>/dev/null || echo "No syslog"
grep -c "error" /var/log/syslog 2>/dev/null || echo "No syslog"
grep -i "failed" /var/log/auth.log 2>/dev/null || echo "No auth.log"

# Show last 5 errors
grep "error" /var/log/syslog 2>/dev/null | tail -5

# Count errors by type
grep "error" /var/log/syslog 2>/dev/null | cut -d: -f2 | sort | uniq -c
```

## Key Takeaways

**Common Flags Quick Reference:**
- `-i` = Case-insensitive
- `-v` = Invert (NOT match)
- `-c` = Count matches
- `-n` = Show line numbers
- `-r` = Recursive search
- `-l` = Filenames only
- `-w` = Whole words only
- `-A 2` = 2 lines after
- `-B 2` = 2 lines before
- `-C 2` = 2 lines context

**Regex Basics:**
- `^` = Start of line
- `$` = End of line
- `.` = Any character
- `*` = Zero or more
- `[abc]` = Any of a, b, or c
- `[^abc]` = NOT a, b, or c
- `|` = OR (with -E flag)
- `+` = One or more (with -E flag)

**Real-World Uses:**
- Search logs for errors and warnings
- Find patterns in code
- Filter configuration files
- Analyze system logs
- Track user activities
- Monitor system events

## Safe Practice Steps
1. Create test log file
2. Practice basic grep: `grep "ERROR" file.txt`
3. Try case-insensitive: `grep -i "warning" file.txt`
4. Count matches: `grep -c "pattern" file.txt`
5. Show line numbers: `grep -n "pattern" file.txt`
6. Invert search: `grep -v "pattern" file.txt`
7. Search recursively: `grep -r "pattern" directory/`
8. Use regex patterns
9. Search actual system logs (with error handling)
10. Combine with other commands

## Resources to Use
- Bash manual: `man grep`
- Regex tutorial: `man 7 regex`
- Real system logs: `/var/log/syslog`, `/var/log/auth.log`
- Practice files with varied content

## Common GREP Workflows

```bash
# Find and count errors
grep "error" file.log | wc -l

# Find errors with context
grep -C 3 "error" file.log

# Find unique errors
grep "error" file.log | sort | uniq

# Find most common errors
grep "error" file.log | cut -d: -f2 | sort | uniq -c | sort -rn | head -5

# Find errors in date range (with timestamps)
grep "2026-09-22 10:1" file.log | grep "ERROR"

# Monitor live log file
tail -f /var/log/syslog | grep "error"

# Find and email results
grep "critical" /var/log/syslog | mail -s "Critical Errors" admin@example.com
```

## Struggle Points

**1. Regular Expression Operators vs Wildcards Confusion**
Beginners confuse shell wildcards (`*`, `?`) with regex operators. In grep, `.` means "any character" (not `*`), and `*` means "zero or more" of the PREVIOUS character (not a wildcard). Regex: `e.*r` matches "error", but `e*r` matches "er", "eeer", etc.

**2. Forgetting to Quote Patterns**
Writing `grep -E file|error file.txt` fails because shell expands `|` as pipe operator.
Must quote: `grep -E "file|error" file.txt`. Patterns need quotes to prevent shell 
interpretation of special characters.

## Notes
- `grep` is case-sensitive by default - use `-i` for case-insensitive
- Empty results don't mean error - just no matches found
- Use quotes around patterns to avoid shell expansion
- `-r` searches all files recursively
- Combine flags: `grep -rni "pattern" directory/`
- Regular expressions are powerful but need `-E` for extended features
- Test regex patterns on small files first
- Use `grep -v "^#"` to skip comments in config files
- Use `grep -v "^$"` to skip blank lines
- System logs often require `sudo` for some directories
- Log files are valuable for troubleshooting - learn to search them
- Combine grep with other tools for powerful text processing
- Always use error redirection `2>/dev/null` on system log searches
