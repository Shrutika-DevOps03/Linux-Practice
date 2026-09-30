# Day 10: Master SED and AWK - Text Processing and Data Extraction

**Time Spent:** 1 hr
**Difficulty:** Intermediate

## Today's Learning
- Learn `sed` (stream editor) for string substitution
- Practice replacing text: old → new
- Use sed flags and options (-i, -e, -n)
- Learn `awk` for column extraction and data processing
- Process CSV-like data with awk
- Understand awk variables and patterns
- Combine sed and awk in pipelines
- Transform structured data efficiently

## Understanding SED (Stream Editor)

### What is SED?
`sed` = "Stream EDitor" - processes text line by line, applying transformations.

```
Basic Syntax: sed [options] 'command' [file]
Most common: sed 's/old/new/' file.txt  (substitute/replace)
```

## SED - Substitution Commands

### Basic Substitution (s command)
```bash
# Replace FIRST occurrence on each line
sed 's/old/new/' file.txt              # Replace first 'old' with 'new'
sed 's/error/ERROR/' log.txt           # Replace first 'error' with 'ERROR'

# Replace ALL occurrences on each line (g flag)
sed 's/old/new/g' file.txt             # Replace ALL 'old' with 'new'
sed 's/cat/dog/g' file.txt             # Replace all 'cat' with 'dog'

# Case-insensitive replacement (i flag)
sed 's/error/ERROR/i' file.txt         # Replace 'error', 'ERROR', 'Error', etc.
sed 's/OLD/new/gi' file.txt            # All occurrences, case-insensitive

# Show only changed lines (n flag)
sed -n 's/pattern/replacement/p' file.txt  # Print only substituted lines
```

### SED Flags and Options

#### -i (In-place editing - MODIFY FILE)
```bash
# CAREFUL: Directly modifies the file
sed -i 's/old/new/g' file.txt          # file.txt is now changed!

# Safer: Create backup
sed -i.bak 's/old/new/g' file.txt      # Creates file.txt.bak as backup

# Verify changes first (without -i)
sed 's/old/new/g' file.txt             # Preview changes
# Then run with -i if happy
sed -i 's/old/new/g' file.txt
```

#### -e (Multiple commands)
```bash
# Execute multiple sed commands
sed -e 's/old/new/g' -e 's/foo/bar/g' file.txt

# Multiple replacements in sequence
sed -e 's/error/ERROR/g' -e 's/warning/WARNING/g' log.txt
```

#### -n (Suppress default output, show only matches)
```bash
# Only show lines where substitution happened
sed -n 's/pattern/replacement/p' file.txt

# Show specific lines (with line numbers)
sed -n '5,10p' file.txt                # Show lines 5-10
sed -n '/pattern/p' file.txt           # Show lines containing pattern
```

### SED - Delete and Print Commands

```bash
# Delete lines matching pattern
sed '/pattern/d' file.txt              # Remove lines with pattern
sed '/^#/d' config.txt                 # Remove comments (lines starting with #)
sed '/^$/d' file.txt                   # Remove blank lines

# Print lines matching pattern
sed -n '/pattern/p' file.txt           # Show only lines with pattern
sed -n '/ERROR/p' log.txt              # Show only ERROR lines

# Print line numbers with matches
sed -n '=/pattern/=' file.txt          # Show line numbers
```

### SED - Address Ranges

```bash
# Apply command to specific lines
sed '5s/old/new/' file.txt             # Substitute only on line 5
sed '5,10s/old/new/g' file.txt         # Lines 5-10
sed '10,$s/old/new/g' file.txt         # Line 10 to end of file

# Apply command to lines matching pattern
sed '/^error/s/old/new/g' file.txt     # Lines starting with "error"
sed '/ERROR/,/WARNING/s/old/new/g' file.txt  # Between ERROR and WARNING
```

## Understanding AWK - Data Processing

### What is AWK?
`awk` = Text processing language - splits input into fields, processes by pattern.

```
Basic Syntax: awk [options] 'pattern { action }' [file]
Most common: awk '{print $1, $3}' file  (print columns 1 and 3)
```

### AWK Field Separators and Columns

```bash
# Default separator is whitespace
awk '{print $1}' file.txt              # First column
awk '{print $2}' file.txt              # Second column
awk '{print $1, $3}' file.txt          # Columns 1 and 3

# Specify custom separator (CSV example)
awk -F',' '{print $2}' data.csv        # Second field (comma-separated)
awk -F':' '{print $1}' /etc/passwd     # First field (colon-separated)

# Multiple separators
awk -F'[ ,:]' '{print $2}' file.txt    # Space, comma, or colon as separator
```

### AWK Built-in Variables

```bash
# NF = Number of Fields (columns)
awk '{print NF}' file.txt              # Show how many columns in each line
awk '{print $NF}' file.txt             # Last column
awk '{print $(NF-1)}' file.txt         # Second-to-last column

# NR = Number of Records (line number)
awk '{print NR, $0}' file.txt          # Line number and full line
awk 'NR>1' file.txt                    # All lines except first (skip header)
awk 'NR==5' file.txt                   # Only line 5

# FS = Field Separator
awk 'BEGIN{FS=","} {print $2}' data.csv  # Set separator in BEGIN block
awk 'BEGIN{FS=":"} {print $1}' /etc/passwd

# FNR = File Record Number (current file only)
awk '{print FNR}' file.txt

# $0 = Entire line
awk '{print $0}' file.txt              # Show all columns (full line)
```

### AWK Patterns and Actions

```bash
# Pattern matching
awk '/ERROR/ {print}' log.txt          # Lines containing ERROR
awk '/^[0-9]/ {print}' file.txt        # Lines starting with number
awk '$2 > 100 {print}' data.txt        # Lines where column 2 > 100

# BEGIN and END blocks
awk 'BEGIN {print "Starting"} {print $1} END {print "Done"}' file.txt

# Count lines with pattern
awk '/ERROR/ {count++} END {print count}' log.txt

# Sum values in column
awk '{sum += $2} END {print sum}' data.txt

# Calculate average
awk '{sum += $2; count++} END {print sum/count}' data.txt
```

## SED Examples - String Substitution

### Simple Replacements
```bash
# Replace single word
sed 's/old/new/' file.txt
sed 's/error/ERROR/g' log.txt

# Replace with special characters (use | or / as delimiter)
sed 's|/path/old|/path/new|g' file.txt
sed 's#old#new#g' file.txt

# Case-insensitive
sed 's/old/new/gi' file.txt

# Show only changed lines
sed -n 's/pattern/replacement/p' file.txt
```

### File Modifications
```bash
# Create backup before modifying
sed -i.bak 's/old/new/g' file.txt
# Creates file.txt.bak with original, file.txt with changes

# Multiple replacements
sed -e 's/old1/new1/g' -e 's/old2/new2/g' file.txt

# Clean up files (remove comments and blank lines)
sed -e '/^#/d' -e '/^$/d' config.txt

# Replace in multiple files
sed -i 's/old/new/g' *.txt            # All .txt files
```

## AWK Examples - Data Extraction and Processing

### Extract Columns
```bash
# Show specific columns
awk '{print $1, $3}' file.txt         # Columns 1 and 3
awk '{print $2}' file.txt             # Column 2 only
awk '{print $NF}' file.txt            # Last column

# CSV data
awk -F',' '{print $1, $3}' data.csv   # Columns 1 and 3 from CSV

# Tab-separated
awk -F'\t' '{print $1, $2}' data.tsv

# Custom separator
awk -F':' '{print $1}' /etc/passwd    # Show usernames
```

### Filter and Process Data
```bash
# Filter lines based on column value
awk '$2 > 50 {print}' data.txt        # Rows where column 2 > 50
awk '$1 == "error" {print}' log.txt   # Rows where column 1 equals "error"
awk 'NF > 3 {print}' file.txt         # Lines with more than 3 columns

# Skip header row
awk 'NR>1 {print}' file.txt           # All except first line
awk 'NR>1 {print $1, $2}' data.csv    # Skip header, show columns
```

### Calculate Values
```bash
# Sum column
awk '{sum += $2} END {print sum}' data.txt

# Average column
awk '{sum += $2; count++} END {print sum/count}' data.txt

# Count lines with condition
awk '/ERROR/ {count++} END {print count}' log.txt

# Find maximum value
awk '{if ($2 > max) max = $2} END {print max}' data.txt

# Find minimum value
awk 'NR==1 {min=$2} $2 < min {min=$2} END {print min}' data.txt
```

## Processing CSV Data

### CSV Extraction
```bash
# CSV file: name,age,city
# Extract age column (column 2)
awk -F',' '{print $2}' people.csv

# Extract name and city
awk -F',' '{print $1, $3}' people.csv

# Filter: show people over 30
awk -F',' '$2 > 30 {print}' people.csv

# Show header and matching rows
awk -F',' 'NR==1 || $2 > 30' people.csv
```

### CSV Analysis
```bash
# Count rows (excluding header)
awk -F',' 'NR>1' people.csv | wc -l

# Average age
awk -F',' 'NR>1 {sum+=$2; count++} END {print "Average:", sum/count}' people.csv

# Find oldest person
awk -F',' 'NR>1 {if ($2 > max) {max=$2; person=$1}} END {print person, max}' people.csv

# Group and count
awk -F',' 'NR>1 {count[$3]++} END {for (city in count) print city, count[city]}' people.csv
```

## Combining SED and AWK

### Pipeline Examples
```bash
# Replace text, then extract columns
cat log.txt | sed 's/ERROR/CRITICAL/g' | awk '{print $1, $NF}'

# Extract columns, then filter
cat data.csv | awk -F',' '{print $1, $2}' | grep "pattern"

# Remove comments, then process
sed '/^#/d' config.txt | awk '{print $1}'

# Clean data, then analyze
sed 's/  */ /g' data.txt | awk '{sum += $2} END {print sum}'
```

## Practice Commands

### Create Test Environment
```bash
# Create test text file
cat > ~/test_data.txt << 'EOF'
apple 10 red
banana 5 yellow
apple 12 red
cherry 8 red
banana 3 yellow
EOF

# Create CSV file
cat > ~/people.csv << 'EOF'
name,age,city
Alice,28,New York
Bob,35,London
Charlie,22,Paris
Diana,31,Tokyo
Eve,26,Berlin
EOF

# Create config file (with comments)
cat > ~/config.txt << 'EOF'
# Database Configuration
host=localhost
port=5432
# User Settings
admin=true
# Debug Mode
debug=false
EOF
```

### SED Practice
```bash
# Simple replacement
sed 's/apple/orange/' ~/test_data.txt
sed 's/apple/orange/g' ~/test_data.txt  # All occurrences

# Case-insensitive
sed 's/APPLE/orange/i' ~/test_data.txt

# In-place with backup
sed -i.bak 's/apple/orange/g' ~/test_data.txt

# Remove comments
sed '/^#/d' ~/config.txt

# Remove blank lines
sed '/^$/d' ~/config.txt

# Multiple operations
sed -e '/^#/d' -e '/^$/d' ~/config.txt
```

### AWK Practice
```bash
# Extract columns
awk '{print $1}' ~/test_data.txt       # First column
awk '{print $1, $3}' ~/test_data.txt   # Columns 1 and 3

# CSV processing
awk -F',' '{print $1}' ~/people.csv    # Names
awk -F',' '{print $1, $2}' ~/people.csv  # Names and ages

# Filter rows
awk '$2 > 10' ~/test_data.txt          # Items with value > 10
awk '$3 == "red"' ~/test_data.txt      # Red items

# Skip header
awk -F',' 'NR>1 {print $1}' ~/people.csv  # Skip header, show names

# Calculate sum
awk '{sum += $2} END {print sum}' ~/test_data.txt

# Count matches
awk '$3 == "red" {count++} END {print count}' ~/test_data.txt
```

### Advanced Practice
```bash
# Replace and extract
sed 's/apple/fruit/g' ~/test_data.txt | awk '{print $1, $2}'

# Process CSV with condition
awk -F',' 'NR>1 && $2 > 25' ~/people.csv

# Find average value
awk -F',' 'NR>1 {sum+=$2; count++} END {print "Average age:", sum/count}' ~/people.csv

# Extract and format
awk -F',' 'NR==1 {next} {printf "%-10s %3d %s\n", $1, $2, $3}' ~/people.csv

# Multiple filters
awk '$2 > 5 && $3 == "red"' ~/test_data.txt
```

## Key Takeaways

**SED - String Substitution:**
- `sed 's/old/new/'` - Replace first occurrence
- `sed 's/old/new/g'` - Replace all occurrences
- `sed -i 's/old/new/g'` - Modify file (use -i.bak for backup)
- `sed 's/old/new/gi'` - Case-insensitive
- `sed '/pattern/d'` - Delete matching lines
- `sed -n '/pattern/p'` - Show only matching lines

**AWK - Data Extraction:**
- `awk '{print $1, $3}'` - Extract columns 1 and 3
- `awk -F',' '{print $2}'` - CSV with custom separator
- `awk 'NR>1'` - Skip header row
- `awk '{sum += $2} END {print sum}'` - Sum column
- `awk '$2 > 50 {print}'` - Filter by column value
- `awk '/ERROR/ {count++} END {print count}'` - Count matches

**Common Patterns:**
- Replace text: `sed 's/old/new/g'`
- Extract columns: `awk '{print $1, $2}'`
- CSV processing: `awk -F',' '{print $2}'`
- Filter data: `awk '$column condition'`
- Aggregate: `awk '{sum += $col} END {print sum}'`

## Safe Practice Steps
1. Create test text file
2. Practice sed: `sed 's/old/new/' file`
3. Practice without -i first (preview changes)
4. Try sed with -i.bak (create backup)
5. Extract columns with awk: `awk '{print $1}'`
6. Try CSV with awk -F','
7. Filter rows with awk: `awk '$2 > 50'`
8. Calculate with awk: `awk '{sum+=$2} END {print sum}'`
9. Combine sed and awk in pipeline
10. Practice on real data

## Resources to Use
- Bash manual: `man sed`, `man awk`
- SED tutorial and examples
- AWK tutorial and guide
- Practice files with varied content
- Real data files (CSV, config files, logs)

## Common SED Patterns

```bash
# Remove comments
sed '/^#/d' file.txt

# Remove blank lines
sed '/^$/d' file.txt

# Both at once
sed -e '/^#/d' -e '/^$/d' file.txt

# Add line numbers
sed = file.txt | sed 'N;s/\n/: /'

# Swap words
sed 's/\([a-z]*\) \([a-z]*\)/\2 \1/' file.txt
```

## Common AWK Patterns

```bash
# Sum column
awk '{sum += $1} END {print sum}'

# Average column
awk '{sum += $1; n++} END {print sum/n}'

# Count lines
awk 'END {print NR}'

# Print with line numbers
awk '{print NR, $0}'

# Skip header, process data
awk 'NR>1 {print}'

# Find max value
awk '$1 > max {max = $1} END {print max}'
```

## Struggle Points
1. SED's -i Flag Silently Destroys Files Without Backup
Beginners run sed -i 's/old/new/g' file.txt expecting preview, not realizing -i immediately modifies the file without confirmation or ability to undo. Many lose important data before learning to always test first without -i or use -i.bak for safety.

2. AWK Field Separator Confusion - Forgetting -F for CSV/Non-Whitespace Data
Students extract wrong columns because they forget to specify -F',' for CSV files, getting confused when awk '{print $2}' data.csv shows wrong data. They don't realize AWK defaults to whitespace as separator, so name,age,city in a CSV gets treated as one field instead of three.

## Notes
- Always test sed WITHOUT -i first to preview changes
- Use -i.bak to create backup before modifying
- AWK is column-based, perfect for structured data (CSV, logs)
- SED is line-based, perfect for text substitution
- Combine them: sed for replacements, awk for extraction
- AWK is surprisingly powerful - can do complex data analysis
- Regular expressions in sed need escaping differently
- Test on small files first before using on important data
- Performance: for large files, sed and awk are faster than loops
- Sed and awk are standard on all Unix/Linux systems
