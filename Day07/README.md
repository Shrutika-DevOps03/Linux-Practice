# Day 7: Master Backup Scripts with Timestamps

**Time Spent:** 1 hr
**Difficulty:** Beginner-Intermediate

## Today's Learning
- Create backup scripts using `cp` command
- Use date command for timestamps
- Backup directories with timestamp filenames
- Write script to list all backups
- Add confirmation prompts using `read`
- Create interactive scripts with user input
- Understand conditional logic for prompts

## Understanding Dates in Bash

### DATE Command Basics
```bash
# Display current date/time
date                              # Full date and time
date +"%Y-%m-%d"                  # 2026-09-21 (YYYY-MM-DD)
date +"%Y%m%d"                    # 20260921 (YYYYMMDD)
date +"%Y-%m-%d_%H-%M-%S"        # 2026-09-21_14-30-45 (with time)
date +"%s"                        # Unix timestamp (seconds since 1970)

# Common date formats
date +"%A"                        # Full day name (Monday)
date +"%B"                        # Full month name (September)
date +"%Y-%m-%d %H:%M:%S"        # 2026-09-21 14:30:45
```

### Using Dates in Variables
```bash
#!/bin/bash
# Store date in variable for use in script

today=$(date +"%Y-%m-%d")
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
filename="backup_$today.tar.gz"
backup_dir="backup_$timestamp"

echo "Backup directory: $backup_dir"
echo "Backup file: $filename"
```

## Understanding User Input with READ

### READ Command Basics
```bash
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
```

## Understanding Conditional Logic (IF statements)

### IF Statement Basics
```bash
# Basic syntax
if [ condition ]; then
    # Commands if condition is true
fi

# With else
if [ condition ]; then
    # Commands if true
else
    # Commands if false
fi

# String comparison
if [ "$name" = "Alice" ]; then
    echo "Hello Alice!"
fi

# Test commands
[ -f file.txt ]                   # -f: file exists
[ -d directory ]                  # -d: directory exists
[ -z "$string" ]                  # -z: string is empty
[ -n "$string" ]                  # -n: string is not empty
[ "$var" = "value" ]              # equals
[ "$var" != "value" ]             # not equals
```

## Creating Backup Scripts

### Backup Script 1: Simple Directory Backup
```bash
#!/bin/bash
# Simple backup script that backs up a directory

# Variables
source_dir="$HOME/myfiles"
backup_location="$HOME/backups"
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_dir="$backup_location/backup_$timestamp"

# Create backup directory if it doesn't exist
mkdir -p "$backup_location"

# Create backup
cp -r "$source_dir" "$backup_dir"

# Confirm completion
echo "Backup completed!"
echo "Backup location: $backup_dir"
```

### Backup Script 2: Backup with Confirmation Prompt
```bash
#!/bin/bash
# Backup script with user confirmation

# Variables
source_dir="$HOME/myfiles"
backup_location="$HOME/backups"
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_dir="$backup_location/backup_$timestamp"

# Display backup details
echo "========== BACKUP SCRIPT =========="
echo "Source directory: $source_dir"
echo "Backup location: $backup_dir"
echo ""

# Ask for confirmation
read -p "Do you want to proceed with backup? (yes/no): " response

# Check response
if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
    echo "Starting backup..."
    mkdir -p "$backup_location"
    cp -r "$source_dir" "$backup_dir"
    echo "✓ Backup completed successfully!"
    echo "Backup location: $backup_dir"
else
    echo "✗ Backup canceled."
    exit 1
fi
```

### Backup Script 3: List All Backups
```bash
#!/bin/bash
# Script to list all backups with details

backup_location="$HOME/backups"

echo "========== BACKUP LIST =========="
echo ""

# Check if backup directory exists
if [ ! -d "$backup_location" ]; then
    echo "No backups found. Directory does not exist."
    exit 1
fi

# Count backups
backup_count=$(ls -1 "$backup_location" | wc -l)
echo "Total backups: $backup_count"
echo ""

# List all backups with details
echo "Backups:"
ls -lhd "$backup_location"/backup_* 2>/dev/null | awk '{print $9, "(" $5 ")"}'

# Alternative: More detailed listing
echo ""
echo "Detailed listing:"
for backup in "$backup_location"/backup_*; do
    if [ -d "$backup" ]; then
        size=$(du -sh "$backup" | cut -f1)
        name=$(basename "$backup")
        echo "  - $name (Size: $size)"
    fi
done
```

### Backup Script 4: Complete Backup System with Options
```bash
#!/bin/bash
# Complete backup script with menu and confirmation

# Variables
backup_base_dir="$HOME/backups"
source_dir="$HOME/myfiles"

# Function to create backup
create_backup() {
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    backup_dir="$backup_base_dir/backup_$timestamp"
    
    echo ""
    echo "========== CREATE BACKUP =========="
    echo "Source: $source_dir"
    echo "Destination: $backup_dir"
    echo ""
    
    # Ask for confirmation
    read -p "Continue with backup? (yes/no): " confirm
    
    if [ "$confirm" = "yes" ] || [ "$confirm" = "y" ]; then
        mkdir -p "$backup_base_dir"
        cp -r "$source_dir" "$backup_dir"
        echo "✓ Backup created successfully!"
    else
        echo "✗ Backup canceled."
    fi
}

# Function to list backups
list_backups() {
    echo ""
    echo "========== BACKUP LIST =========="
    echo ""
    
    if [ ! -d "$backup_base_dir" ]; then
        echo "No backups found."
        return
    fi
    
    count=0
    for backup in "$backup_base_dir"/backup_*; do
        if [ -d "$backup" ]; then
            size=$(du -sh "$backup" | cut -f1)
            name=$(basename "$backup")
            echo "$name (Size: $size)"
            ((count++))
        fi
    done
    
    echo ""
    echo "Total backups: $count"
}

# Function to delete old backups
delete_backups() {
    echo ""
    echo "========== DELETE OLD BACKUPS =========="
    
    if [ ! -d "$backup_base_dir" ]; then
        echo "No backups found."
        return
    fi
    
    read -p "Delete backups older than 7 days? (yes/no): " confirm
    
    if [ "$confirm" = "yes" ] || [ "$confirm" = "y" ]; then
        find "$backup_base_dir" -type d -mtime +7 -exec rm -rf {} \;
        echo "✓ Old backups deleted."
    else
        echo "✗ Delete canceled."
    fi
}

# Main menu
echo "========== BACKUP SYSTEM =========="
echo "1. Create backup"
echo "2. List backups"
echo "3. Delete old backups"
echo "4. Exit"
echo ""

read -p "Select option (1-4): " option

case $option in
    1) create_backup ;;
    2) list_backups ;;
    3) delete_backups ;;
    4) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid option"; exit 1 ;;
esac
```

## Practice Commands

### Step-by-Step Practice

#### Practice 1: Create Test Directory for Backup
```bash
# Create test directory with files
mkdir -p ~/test_data/documents
mkdir -p ~/test_data/images
echo "Important document" > ~/test_data/documents/file1.txt
echo "Another document" > ~/test_data/documents/file2.txt
echo "Test" > ~/test_data/test.txt

# Verify structure
tree ~/test_data
# or
find ~/test_data -type f
```

#### Practice 2: Simple Backup Script
```bash
# Create backup script
cat > ~/backup_simple.sh << 'EOF'
#!/bin/bash
# Simple backup script

source_dir="$HOME/test_data"
backup_dir="$HOME/backups/backup_$(date +%Y-%m-%d_%H-%M-%S)"

mkdir -p "$(dirname "$backup_dir")"
cp -r "$source_dir" "$backup_dir"

echo "Backup completed!"
echo "Location: $backup_dir"
EOF

# Make executable and run
chmod +x ~/backup_simple.sh
~/backup_simple.sh
```

#### Practice 3: Backup with Confirmation
```bash
# Create backup with confirmation
cat > ~/backup_confirm.sh << 'EOF'
#!/bin/bash
# Backup with confirmation prompt

source_dir="$HOME/test_data"
backup_base="$HOME/backups"
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_dir="$backup_base/backup_$timestamp"

echo "========== BACKUP =========="
echo "Source: $source_dir"
echo "Destination: $backup_dir"
echo ""

read -p "Proceed? (yes/no): " response

if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
    mkdir -p "$backup_base"
    cp -r "$source_dir" "$backup_dir"
    echo "✓ Success!"
else
    echo "✗ Canceled."
    exit 1
fi
EOF

chmod +x ~/backup_confirm.sh
~/backup_confirm.sh
```

#### Practice 4: List Backups Script
```bash
# Create list backups script
cat > ~/list_backups.sh << 'EOF'
#!/bin/bash
# List all backups

backup_base="$HOME/backups"

echo "========== BACKUPS =========="
echo ""

if [ ! -d "$backup_base" ]; then
    echo "No backups found."
    exit 0
fi

count=0
for backup in "$backup_base"/backup_*; do
    if [ -d "$backup" ]; then
        size=$(du -sh "$backup" | cut -f1)
        name=$(basename "$backup")
        echo "$name ($size)"
        ((count++))
    fi
done

echo ""
echo "Total: $count backup(s)"
EOF

chmod +x ~/list_backups.sh
~/list_backups.sh
```

#### Practice 5: Complete Backup System
```bash
# Create complete system
cat > ~/backup_system.sh << 'EOF'
#!/bin/bash
# Complete backup system

backup_base="$HOME/backups"
source_dir="$HOME/test_data"

backup() {
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    backup_dir="$backup_base/backup_$timestamp"
    
    echo "Creating backup: $backup_dir"
    read -p "Continue? (y/n): " -n 1 confirm
    echo ""
    
    if [ "$confirm" = "y" ]; then
        mkdir -p "$backup_base"
        cp -r "$source_dir" "$backup_dir"
        echo "✓ Backup created"
    else
        echo "✗ Canceled"
    fi
}

list() {
    echo "========== BACKUPS =========="
    ls -lhd "$backup_base"/backup_* 2>/dev/null || echo "No backups found"
}

# Menu
case "${1:-menu}" in
    backup|b) backup ;;
    list|l) list ;;
    *)
        echo "Usage: $0 {backup|list}"
        ;;
esac
EOF

chmod +x ~/backup_system.sh
~/backup_system.sh backup
~/backup_system.sh list
```

## Understanding the READ Command Better

### READ with Different Prompts
```bash
#!/bin/bash
# Examples of read prompts

# Simple read
read -p "Enter name: " name
echo "Hello, $name"

# Yes/No question
read -p "Continue? (yes/no): " response
if [ "$response" = "yes" ]; then
    echo "Continuing..."
fi

# Single character
read -p "Continue? (y/n): " -n 1 response
echo ""
if [ "$response" = "y" ]; then
    echo "Continuing..."
fi

# With default value
read -p "Enter backup location [/home/user/backups]: " location
location=${location:-/home/user/backups}
echo "Using: $location"

# Silent input (password)
read -sp "Password: " password
echo ""
echo "Password accepted"
```

## Key Takeaways

**Date Formatting:**
- `$(date +"%Y-%m-%d")` - YYYY-MM-DD format
- `$(date +"%Y-%m-%d_%H-%M-%S")` - With timestamp
- Always use dates for backup filenames

**User Input (read command):**
- `read -p "Prompt: " variable` - Get user input
- `-p` option shows prompt message
- Check response with `if [ "$response" = "yes" ]`
- `-n 1` for single character input
- `-s` for silent input (passwords)

**Conditional Logic:**
- `if [ condition ]; then ... fi`
- Test file exists: `[ -f file ]`
- Test directory exists: `[ -d directory ]`
- String equals: `[ "$var" = "value" ]`
- String not equals: `[ "$var" != "value" ]`

**Backup Best Practices:**
- Always use timestamps in backup names
- Create backup directory if missing: `mkdir -p`
- Ask for confirmation before destructive operations
- List backups to verify they exist
- Consider backup retention (delete old backups)
- Use human-readable backup names

## Safe Practice Steps
1. Create test directory: `mkdir -p ~/test_data`
2. Add files to test directory
3. Create simple backup script
4. Make executable: `chmod +x script.sh`
5. Run backup
6. Verify backup created: `ls -la ~/backups`
7. Add confirmation prompt
8. Test with "yes" and "no" responses
9. Create list backups script
10. Test entire system

## Resources to Use
- Bash manual: `man bash`, `man read`, `man date`
- Test scripts on test directories only
- Never backup production data first time
- Start simple, add features incrementally

## Common Backup Patterns

```bash
# Daily backup
backup_$(date +"%Y-%m-%d").tar.gz

# Timestamped backup
backup_$(date +"%Y-%m-%d_%H-%M-%S")/

# Weekly rotation
backup_week_$(date +%V).tar.gz

# Numbered sequence
backup_001, backup_002, etc.
```

## Struggle Points


## Notes
- Always test backup scripts on test data first
- Use meaningful backup names with timestamps
- Ask for confirmation before backup operations
- List backups to verify they completed
- Consider implementing backup rotation (delete old)
- Use `cp -r` to backup directories recursively
- `tar` and `gzip` are better for real backups (we'll learn later)
- Make backups to external location if possible
- Schedule backups with cron (we'll learn later)
- Keep backup scripts in version control
- Document your backup strategy
- Test restore process (backup is useless if can't restore)
