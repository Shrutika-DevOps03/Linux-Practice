# Day 5: Master File Searching Commands

**Time Spent:** 45 minute
**Difficulty:** Intermediate

## Today's Learning
- Learn `find` command (comprehensive file search)
- Search by name with `-name` and `-iname`
- Search by type with `-type`
- Search by size with `-size`
- Search by modification time with `-mtime`
- Learn `locate` command (fast database search)
- Combine `find` with `-exec` to run commands
- Use `find` to search entire filesystem efficiently

## Commands to Practice

### FIND - Powerful File Search Command

#### Basic Find Syntax
```bash
find [path] [options] [action]

# Most common usage
find /path -name "filename"       # Search by name
find /path -type f               # Search by type
find /path -size +100M            # Search by size
```

#### FIND by NAME
```bash
# Basic name search
find /home -name "*.txt"          # Find all .txt files
find /home -name "test*"          # Files starting with 'test'
find /home -name "*backup*"       # Files containing 'backup'
find / -name "passwd"             # Find passwd file anywhere

# Case-insensitive search
find /home -iname "*.TXT"         # Find .txt, .TXT, .Txt etc.
find /home -iname "TEST*"         # Case-insensitive 'test'

# Exact name match
find /home -name "document.pdf"   # Exact filename
```

#### FIND by TYPE
```bash
# File types
find /home -type f               # Regular files only
find /home -type d               # Directories only
find /home -type l               # Symbolic links
find /home -type f -name "*.log" # Log files (regular files)

# Combining with other criteria
find /etc -type f -name "*.conf" # Config files
find /var -type d -name "cache*" # Cache directories
```

#### FIND by SIZE
```bash
# Size search (c=bytes, k=KB, M=MB, G=GB)
find /home -size +100M            # Larger than 100MB
find /home -size -10k             # Smaller than 10KB
find /home -size 5M               # Exactly 5MB
find / -type f -size +1G          # Files larger than 1GB

# Useful size searches
find /var -type f -size +100M     # Large log files
find /home -type f -size 0        # Empty files
find /tmp -type f -size +500M     # Large temp files
```

#### FIND by MODIFICATION TIME
```bash
# Time-based search (-mtime uses days)
find /home -mtime -1              # Modified in last 24 hours
find /home -mtime -7              # Modified in last 7 days
find /home -mtime +30             # Modified more than 30 days ago
find /home -mtime 0               # Modified exactly today

# Minute-based search (more precise)
find /home -mmin -60              # Modified in last 60 minutes
find /home -mmin -30              # Modified in last 30 minutes
find /home -mmin +1440            # Not modified in last 24 hours

# Combined with type
find /var/log -type f -mtime -1   # Logs modified today
find /tmp -type f -mtime +7       # Old temp files
```

#### FIND with MULTIPLE CONDITIONS
```bash
# AND (both conditions must match)
find /home -name "*.txt" -type f               # .txt files that are regular files
find /home -name "*.log" -mtime -7 -type f    # Log files modified in last week
find / -type f -size +100M -mtime -30         # Large files modified recently

# OR (either condition can match) - use -o
find /home -name "*.txt" -o -name "*.doc"     # .txt or .doc files

# NOT (inverse match) - use !
find /home -type f ! -name "*.txt"            # Everything except .txt files
```

#### FIND with EXEC - Run Commands
```bash
# Basic exec syntax (dangerous - be careful!)
find /path -name "pattern" -exec command {} \;

# SAFE examples:
find /tmp -type f -name "*.tmp" -exec ls -l {} \;
# Lists details of all .tmp files

find /tmp -type f -mtime +30 -exec rm {} \;
# Delete files older than 30 days (DANGEROUS - test first!)

find /home -name "*.txt" -exec wc -l {} \;
# Count lines in all .txt files

find /home -name "*.log" -exec grep "ERROR" {} \;
# Search for ERROR in all .log files

# SAFER: Use -exec with confirmation
find /tmp -type f -mtime +30 -exec rm -i {} \;
# Ask before deleting each file

# Or use with printf instead of echo
find /home -name "*.txt" -exec echo "Found: " {} \;

# Multiple commands with -exec
find /var/log -name "*.log" -exec ls -lh {} \; -exec wc -l {} \;
```

#### FIND Special Options
```bash
# Limit search depth
find /home -maxdepth 2 -name "*.txt"          # Search 2 levels deep
find /home -mindepth 2 -name "*.txt"          # Start 2 levels deep

# Readable output
find /home -name "*.txt" -print               # Default (prints path)
find /home -name "*.txt" -printf "%p\n"       # Formatted output

# No permission errors
find / -name "*.txt" 2>/dev/null              # Hide "Permission denied" errors
```

### LOCATE - Fast Database Search

```bash
# Basic locate usage
locate filename                   # Search file in database
locate "*.txt"                    # Search by pattern
locate -i filename                # Case-insensitive search
locate -c pattern                 # Count matches only
locate -l 10 filename              # Limit to 10 results

# Update database
sudo updatedb                     # Update locate database
                                  # (Run periodically for fresh data)

# Common patterns
locate "passwd"                   # Find all passwd-related files
locate ".bashrc"                  # Find all .bashrc files
locate "/etc/*.conf"              # Config files in /etc
```

## Practice Commands

### Create Test Environment
```bash
# Create test files for searching
mkdir -p /tmp/find_practice/docs /tmp/find_practice/logs
touch /tmp/find_practice/test.txt
touch /tmp/find_practice/test.log
touch /tmp/find_practice/docs/document.txt
touch /tmp/find_practice/docs/archive.zip
echo "This is a test file" > /tmp/find_practice/logs/error.log
dd if=/dev/zero of=/tmp/find_practice/largefile.bin bs=1M count=10
```

### Practice Search Scenarios
```bash
# Find by name
find /tmp/find_practice -name "*.txt"
find /tmp/find_practice -name "*test*"
find /tmp/find_practice -iname "TEST*"

# Find by type
find /tmp/find_practice -type f              # All files
find /tmp/find_practice -type d              # All directories

# Find by size
find /tmp/find_practice -type f -size +5M    # Large files
find /tmp/find_practice -type f -size -1k    # Small files

# Find by time
find /tmp/find_practice -mtime -1            # Modified today
find /tmp/find_practice -mmin -30            # Modified in last 30 min

# Find on system
find /home -name ".bashrc"                   # Find bashrc files
find /etc -type f -name "*.conf"             # Find config files
find /var/log -type f -mtime -1              # Recent logs
```

### Find with Exec Examples
```bash
# SAFE EXAMPLES (read-only):
find /tmp/find_practice -type f -exec ls -lh {} \;
# List details of all files

find /tmp/find_practice -name "*.txt" -exec wc -l {} \;
# Count lines in all .txt files

find /tmp/find_practice -type f -exec file {} \;
# Show file type for all files

# DANGEROUS (modifying) - TEST CAREFULLY:
find /tmp/find_practice -name "*.tmp" -exec rm {} \;
# Delete all .tmp files (CAREFUL!)

# Always test first with -print:
find /tmp/find_practice -name "*.tmp" -print
# See what will be deleted before using -exec rm
```

### Real System Searches
```bash
# Find system files
find /etc -name "*.conf" -type f             # Config files
find /home -name ".*" -type f                # Hidden files
find / -name "passwd" 2>/dev/null            # Find passwd file
find /var/log -type f -mtime -1              # Recent logs
find / -type f -size +500M 2>/dev/null       # Large files

# Locate examples
locate "ssh"                                  # Find SSH-related files
locate ".bashrc"                              # Find all .bashrc
locate "postgresql"                           # Find postgres files
```

## Key Takeaways

**When to use each command:**
- **find**: Comprehensive, real-time, many options, slower
- **locate**: Fast, pattern-based, uses database, less flexible

**Search Options Quick Reference:**
- `-name "pattern"` - Exact or wildcard match
- `-iname "pattern"` - Case-insensitive match
- `-type f` (file), `-type d` (directory), `-type l` (link)
- `-size +100M` (larger), `-size -10k` (smaller), `-size 5M` (exact)
- `-mtime -1` (last 24h), `-mtime -7` (last week)
- `-mmin -60` (last hour)
- `-exec command {} \;` - Run command on results

**Safety with Find:**
1. Always test with `-print` first if using `-exec`
2. Use `-i` option with `-exec rm` to get confirmation
3. Use `2>/dev/null` to hide permission errors
4. Don't use `find /` on production systems casually

## Safe Practice Steps
1. Create practice directory: `mkdir -p /tmp/find_test`
2. Create test files with different types and sizes
3. Practice find with `-name`: `find /tmp/find_test -name "*.txt"`
4. Practice find with `-type`: `find /tmp/find_test -type f`
5. Practice find with `-size`: `find /tmp/find_test -size +5M`
6. Practice find with `-mtime`: `find /tmp/find_test -mtime -1`
7. Practice find with `-exec` (read-only): `find /tmp/find_test -type f -exec ls -l {} \;`
8. Practice locate: `locate bash`
9. Update locate: `sudo updatedb`
10. Combine multiple options: `find /tmp/find_test -name "*.log" -mtime -7 -type f`

## Resources to Use
- Bash manual: `man find`, `man locate`
- Find man page has excellent examples
- Linux man pages documentation
- Practice on test directories first

## Common Find Patterns

```bash
# Find recently changed files
find /home -mtime -7 -type f                 # Last 7 days

# Find large files to clean up
find /var -type f -size +100M                # Over 100MB

# Find old cache/temp files
find /tmp -type f -mtime +30                 # Over 30 days old
find ~/.cache -type f -mtime +90             # Cache older than 3 months

# Find and delete (DANGEROUS - be careful)
find /tmp -name "*.tmp" -mtime +7 -delete    # Delete old tmp files

# Find with grep
find /home -name "*.txt" -exec grep -l "error" {} \;
# Find .txt files containing "error"

# Find duplicates
find /home -type f -name "*.pdf" -size +10M  # Large PDFs
```

## Struggle Points

1. Understanding -exec syntax
- The {} and \; notation is confusing
- Knowing when to use -exec vs piping
- Understanding why quotes matter: '{}' \; vs {} \;
- Risk of accidentally running destructive commands

2. Locate database outdated
- Finding that locate doesn't show recently created files
- Not knowing to run sudo updatedb to refresh database
- Thinking locate is broken when it's just stale data

## Notes
- `find` searches in real-time, slower but more accurate
- `locate` uses a database, much faster but may be outdated
- Always update locate database with `sudo updatedb` for fresh data
- Use `2>/dev/null` to suppress permission errors on full filesystem searches
- `-exec` is powerful but dangerous - always test first
- Always quote patterns: `find /path -name "*.txt"` not `find /path -name *.txt`
- Combine multiple conditions with AND (default)
- Use `-o` for OR logic
- Use `!` for NOT logic
- Test destructive commands with `-print` first
- Use `-maxdepth` to limit search depth for speed
