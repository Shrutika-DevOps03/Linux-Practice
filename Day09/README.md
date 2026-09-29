# Day 9: Master Pipes and Input/Output Redirection

**Time Spent:** 1 hr
**Difficulty:** Beginner-Intermediate

## Today's Learning
- Understand pipes (`|`) - chain commands together
- Learn output redirection (`>`, `>>`)
- Use input redirection (`<`)
- Combine multiple commands with pipes
- Understanding stdin, stdout, stderr
- Redirect errors separately (`2>`)
- Create data processing pipelines
- Chain 3+ commands effectively

## Understanding Data Streams

### What are Stdin, Stdout, Stderr?
```
stdin  (0) = Standard Input  - Data coming IN to program
stdout (1) = Standard Output - Normal output from program
stderr (2) = Standard Error  - Error messages from program

Example:
command < input.txt           # stdin from file
command > output.txt          # stdout to file
command 2> error.txt          # stderr to file
```

## PIPES (|) - Chain Commands Together

### Basic Pipe Syntax
```bash
# Pipe: Take output of command1, feed as input to command2
command1 | command2

# Multiple pipes
command1 | command2 | command3 | command4

# Reads as: command1 output → command2 input → command3 input → etc.
```

### Simple Pipe Examples
```bash
# Basic pipes
cat file.txt | wc -l              # Count lines in file
cat file.txt | grep "error"        # Find errors in output
ls -l | grep "^d"                 # Show only directories
ps aux | grep "bash"              # Find bash processes

# Multiple pipes
cat log.txt | grep "ERROR" | wc -l    # Count ERROR lines
cat file.txt | sort | uniq             # Unique sorted lines
cat file.txt | grep "pattern" | tail -5  # Last 5 matches

# Practical examples
du -sh * | sort -rh | head -5     # Top 5 largest directories
netstat -an | grep LISTEN         # Show listening ports
ps aux | grep python | grep -v grep  # Find python (skip grep itself)
```

### Understanding How Pipes Work
```bash
# This command:
cat data.txt | grep "error" | wc -l

# Actually works like:
# 1. cat data.txt outputs each line
# 2. grep receives those lines, filters for "error"
# 3. wc -l receives filtered lines, counts them

# Without pipes (using temp file - inefficient):
cat data.txt > temp.txt
grep "error" temp.txt > temp2.txt
wc -l temp2.txt
rm temp.txt temp2.txt
```

## OUTPUT REDIRECTION (>, >>)

### Redirect to File (> - Overwrite)
```bash
# Create/overwrite file with output
echo "Hello" > file.txt            # file.txt now contains "Hello"
ls -l > directory_list.txt        # Save directory listing

# Careful: > OVERWRITES file
command > file.txt                # file.txt is replaced (old content lost)

# Redirect both stdout and stderr
command > output.txt 2>&1         # All output to one file
```

### Append to File (>> - Add to End)
```bash
# Append output to file (don't overwrite)
echo "Line 2" >> file.txt         # Adds to end of file
cat log.txt >> all_logs.txt       # Append log to main file

# Safe for repeated appends
echo "$(date)" >> logfile.txt     # Add timestamp each time
```

### Redirect Errors (2>)
```bash
# Redirect standard error only
command 2> error.log              # Errors to file, output to screen
grep "pattern" file.txt 2> errors.txt  # Errors to file

# Redirect stderr and stdout separately
command 1> output.txt 2> error.txt    # stdout and stderr to different files
command > output.txt 2> error.txt     # (same - default is 1)

# Discard errors
command 2> /dev/null              # Errors disappear
grep "pattern" * 2>/dev/null      # Hide "Permission denied" errors

# Combine stderr and stdout
command 2>&1 | grep "pattern"     # Pipe both stdout and stderr
command &> output.txt             # Both to same file
```

### Append Errors
```bash
# Append error output
command 2>> error.log             # Append errors to log
command >> output.txt 2>> error.log  # Append both separately
```

## INPUT REDIRECTION (<)

### Basic Input Redirection
```bash
# Read from file instead of typing/piping
wc < file.txt                     # Count lines using file as input
sort < unsorted.txt               # Sort file content
grep "pattern" < file.txt         # Search file

# Useful when command doesn't support file argument
cat < file.txt                    # Same as: cat file.txt
head -5 < file.txt                # Same as: head -5 file.txt
```

### Combining Input and Output
```bash
# Read input from file, write output to another file
sort < input.txt > output.txt     # Sort input.txt, save to output.txt

# Read input, redirect errors, save output
grep "pattern" < data.txt > results.txt 2> errors.txt

# Real-world example
cat < addresses.txt | grep "error" > error_addresses.txt 2> grep_errors.log
```

## Combining Multiple Commands with Pipes

### Simple Pipeline (2 commands)
```bash
cat file.txt | grep "error"       # Read file, find errors
ps aux | grep "python"            # List processes, find python
ls -la | sort -k5 -rn             # List files, sort by size
```

### Medium Pipeline (3 commands)
```bash
# Find, filter, count
cat file.txt | grep "ERROR" | wc -l
# Read file → find ERROR lines → count lines

# List, filter, sort
ls -l | grep "\.txt$" | sort -k5 -rn
# List files → find .txt files → sort by size (largest first)

# Search, extract, unique
grep "user" /var/log/auth.log | cut -d: -f5 | sort | uniq
# Find user lines → extract username → get unique users
```

### Complex Pipeline (4+ commands)
```bash
# Find errors, show details, format nicely
cat server.log | grep "ERROR" | cut -d: -f2- | sort | uniq -c | sort -rn
# Read log → find errors → extract message → sort → count occurrences → sort by count

# Find large old files, show with dates
find /tmp -type f -mtime +30 | xargs ls -lh | awk '{print $5, $9}' | sort -rh
# Find old files → show details → show size and name → sort by size

# Process Apache logs
cat access.log | awk '{print $1}' | sort | uniq -c | sort -rn | head -10
# Read log → extract IP → count → sort by count → show top 10

# Find unique errors and their count
grep "error" app.log | cut -d: -f3 | sort | uniq -c | sort -rn
# Find errors → extract error message → count → sort by frequency
```

## Practical Piping Examples

### System Information
```bash
# Who is logged in?
who | wc -l                       # Count logged in users
who | cut -d' ' -f1 | sort | uniq # List unique usernames

# What processes use most memory?
ps aux | sort -k4 -rn | head -5   # Top 5 memory-using processes

# Disk usage by directory
du -sh * | sort -rh | head -10    # Top 10 largest directories
```

### Log File Analysis
```bash
# Count error types
grep "ERROR" server.log | cut -d: -f2 | sort | uniq -c | sort -rn

# Find repeated errors
grep "error" app.log | grep -o "Error: [^,]*" | sort | uniq -c | sort -rn

# Show errors with timestamps
grep "ERROR" server.log | cut -d' ' -f1-3 | head -10

# Find errors from specific time
grep "10:15" server.log | grep "ERROR" | wc -l
```

### Text Processing
```bash
# Extract and count words
cat file.txt | tr ' ' '\n' | sort | uniq -c | sort -rn

# Find longest lines
cat file.txt | awk '{print length, $0}' | sort -rn | head -5

# Show line numbers with matches
cat file.txt | grep -n "pattern" | head -10

# Replace in multiple files
find . -name "*.txt" -exec sed 's/old/new/g' {} \;
```

## Practice Commands

### Create Test Environment
```bash
# Create test data file
cat > ~/data.txt << 'EOF'
apple 10
banana 5
cherry 8
apple 12
banana 3
date 7
apple 9
EOF

# Create test log file
cat > ~/test.log << 'EOF'
2026-09-23 10:15:32 INFO: System started
2026-09-23 10:15:45 ERROR: Database connection failed
2026-09-23 10:16:10 INFO: User logged in
2026-09-23 10:16:22 ERROR: File not found
2026-09-23 10:16:45 WARNING: Memory low
2026-09-23 10:17:00 ERROR: Backup failed
2026-09-23 10:17:15 INFO: Cleanup complete
EOF
```

### Basic Pipe Practice
```bash
# Simple pipes
cat ~/data.txt | wc -l            # Count lines
cat ~/data.txt | grep "apple"     # Find apple
cat ~/data.txt | sort             # Sort content
cat ~/data.txt | sort -k2 -rn     # Sort by second column (descending)

# Count with grep
grep "ERROR" ~/test.log | wc -l   # Count errors
cat ~/data.txt | grep "apple" | wc -l  # Count apples
```

### Output Redirection Practice
```bash
# Create files with redirection
cat ~/data.txt > ~/data_copy.txt  # Copy file
cat ~/data.txt | grep "apple" > ~/apples.txt  # Save results

# Append to files
echo "New line" >> ~/data.txt     # Add to data.txt
grep "ERROR" ~/test.log >> ~/errors.log  # Append errors

# Save errors separately
grep "pattern" ~/test.log > ~/results.txt 2> ~/errors.txt
```

### Multiple Pipe Practice
```bash
# 2-command pipelines
cat ~/data.txt | grep "apple"     # Filter
cat ~/data.txt | sort -k2         # Sort

# 3-command pipelines
cat ~/data.txt | grep "apple" | awk '{print $2}'  # Filter, extract column
cat ~/test.log | grep "ERROR" | cut -d: -f2  # Find errors, extract message

# 4+ command pipelines
cat ~/data.txt | grep "apple" | awk '{sum+=$2} END {print sum}'  # Sum apples
cat ~/test.log | grep "ERROR" | cut -d' ' -f4 | sort | uniq -c | sort -rn
```

### Complex Workflow Practice
```bash
# Find, count, and sort
cat ~/test.log | cut -d' ' -f3 | grep -o "[A-Z]*" | sort | uniq -c | sort -rn
# Extract third column → find words → count → sort by frequency

# Pipe with error handling
cat ~/test.log | grep "ERROR" | cut -d: -f2 > ~/errors.txt 2> ~/parse_errors.txt

# Write results to file
cat ~/data.txt | sort -k2 -rn > ~/sorted_data.txt
```

## Advanced Pipeline Patterns

### Filtering and Aggregating
```bash
# Count occurrences
cat file.txt | sort | uniq -c | sort -rn

# Find top results
ps aux | sort -k3 -rn | head -5

# Extract and count
grep "pattern" file.txt | cut -d: -f2 | sort | uniq -c
```

### Processing Logs
```bash
# Error analysis
grep "ERROR" logfile.txt | cut -d' ' -f1-3 | sort | uniq -c

# User tracking
grep "LOGIN" auth.log | awk '{print $1}' | sort | uniq -c | sort -rn

# Time-based analysis
grep "10:15" logfile.txt | grep "ERROR" | wc -l
```

### Data Transformation
```bash
# Convert format
cat csv.txt | tr ',' '\n' | sort | uniq -c

# Combine files
cat file1.txt file2.txt | sort | uniq

# Deduplicate and count
cat file.txt | sort | uniq -c | sort -rn
```

## Key Takeaways

**Pipes (|):**
- Chain commands: output of command1 → input of command2
- Enables data processing pipelines
- Can chain many commands: cmd1 | cmd2 | cmd3 | cmd4
- More efficient than creating temp files

**Output Redirection (>, >>):**
- `>` - Send output to file (overwrites)
- `>>` - Append output to file
- `2>` - Send errors to file
- `2>&1` - Send both output and errors
- `> /dev/null` - Discard output
- `2> /dev/null` - Discard errors

**Input Redirection (<):**
- `<` - Read input from file
- Alternative to piping from cat
- `command < file` same as `cat file | command`

**Common Pipeline Patterns:**
- Filter: `cat file | grep "pattern"`
- Sort: `command | sort`
- Count: `command | wc -l`
- Extract: `command | cut -d: -f2`
- Unique: `command | sort | uniq -c`
- Top results: `command | head -5`

## Safe Practice Steps
1. Create test files with sample data
2. Practice single pipes: `cat file | grep "pattern"`
3. Practice output redirection: `command > file.txt`
4. Practice append: `command >> file.txt`
5. Practice error redirection: `command 2> error.txt`
6. Practice input redirection: `sort < file.txt`
7. Combine output and input: `sort < in.txt > out.txt`
8. Create 3-command pipeline
9. Create 4+ command pipeline
10. Practice with real system commands

## Resources to Use
- Bash manual: `man bash`, look for "Redirections"
- Each command's manual for pipe support
- Practice files with varied content
- System commands like: ls, cat, grep, sort, uniq, wc, awk, cut

## Common Pipeline Mistakes

```bash
# WRONG: Trying to redirect before pipe
grep pattern | > file.txt          # Error!
# RIGHT:
grep pattern file.txt > output.txt

# WRONG: Forgetting quotes with special characters
echo text | grep |                 # Error! | needs escaping
# RIGHT:
echo "text|data" | grep "text|"

# WRONG: Pipes don't work in all commands
cd /tmp | cd /home               # cd changes shell, not inherited
# RIGHT: Use && or () for commands affecting shell state
cd /tmp && pwd
(cd /tmp && pwd)

# WRONG: Losing data with >
cat important.txt > output.txt     # If output.txt exists, it's overwritten!
# RIGHT: Use >> to append safely
cat important.txt >> output.txt
```

## Struggle Points
1. Accidentally Overwriting Files with >
Beginners don't realize > silently overwrites files without warning. Writing cat important.txt > output.txt multiple times seems safe, but if they later do command > important.txt, the original file is lost forever with no confirmation. Many learn this the hard way.

2. Redirecting Errors: Confusing stdout vs stderr
Students struggle distinguishing between 2> (errors) and 1> (output). They write grep pattern file 2> errors.txt expecting error messages but missing the main output going to screen, or write cmd > results.txt 2>&1 without understanding that 2>&1 means "send stderr TO stdout's destination."

## Notes
- Pipes are one of Unix's greatest strengths - combine small tools to do complex work
- Commands designed to work with pipes (read stdin, write stdout)
- Use `< ` when input redirection makes code clearer
- Redirect errors with `2>` to see actual program output
- Use `/dev/null` to discard unwanted output
- Test pipelines step-by-step: test cmd1, then cmd1|cmd2, then cmd1|cmd2|cmd3
- Count with `wc -l` to verify pipeline is working
- `tee` command can both save and pipe: `command | tee output.txt | next-command`
- Pipelines can be slow with very large files - consider if a single command is better
- Most powerful Unix feature: small tools combining with pipes (Unix Philosophy)
