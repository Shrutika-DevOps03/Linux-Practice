# Day 4: Master File Viewing Commands

**Time Spent:** 1 hr
**Difficulty:** Beginner

## Today's Learning
- Learn `cat` command (concatenate and display files)
- Learn `less` command (paged file viewer)
- Learn `more` command (simple paged viewer)
- Learn `head` command (view first lines)
- Learn `tail` command (view last lines)
- Understand `/etc/passwd` file structure
- Combine files using `cat`

## Commands to Practice

### CAT - Display and Concatenate Files
```bash
# Basic file viewing
cat file.txt                      # Display entire file
cat file1.txt file2.txt           # Display multiple files
cat file1.txt file2.txt > combined.txt  # Combine files into new file
cat >> file.txt << EOF            # Append text to file (here document)
This is new text
EOF

# CAT Options
cat -n file.txt                   # Show line numbers
cat -A file.txt                   # Show special characters ($, ^I for tab)
cat -s file.txt                   # Squeeze blank lines
cat -b file.txt                   # Number non-empty lines only
```

### HEAD - View First Lines
```bash
# View first 10 lines (default)
head file.txt                     # Show first 10 lines
head -n 5 file.txt                # Show first 5 lines
head -n 20 file.txt               # Show first 20 lines
head -c 100 file.txt              # Show first 100 characters

# Useful for system files
head /etc/passwd                  # See first users in system
head /etc/hosts                   # See hostname mappings
```

### TAIL - View Last Lines
```bash
# View last 10 lines (default)
tail file.txt                     # Show last 10 lines
tail -n 5 file.txt                # Show last 5 lines
tail -n 20 file.txt               # Show last 20 lines
tail -c 100 file.txt              # Show last 100 characters
tail -f file.txt                  # Follow file (useful for logs)
tail -f /var/log/syslog           # Watch system log in real-time
```

### LESS - Advanced Paged Viewer (Recommended)
```bash
# Open file in less
less file.txt                     # View file with paging

# Inside LESS (press keys while viewing):
# Navigation
Space         # Next page
b             # Previous page
j             # Next line
k             # Previous line
G             # Go to end of file
g             # Go to beginning
:10           # Go to line 10
/word         # Search for word
n             # Next search result
N             # Previous search result
h             # Help
q             # Quit

# Options
less +G file.txt                  # Open at end of file
less -N file.txt                  # Show line numbers
less -S file.txt                  # Don't wrap long lines
```

### MORE - Simple Paged Viewer
```bash
# Open file in more
more file.txt                     # View file with paging

# Inside MORE:
Space         # Next page
Enter         # Next line
/word         # Search for word
q             # Quit
```

## Understanding /etc/passwd File Structure
```
Format: username:password:uid:gid:comment:home:shell

Example line:
root:x:0:0:root:/root:/bin/bash
│    │  │ │  │    │     │
│    │  │ │  │    │     └─ Login shell (what runs when they log in)
│    │  │ │  │    └─ Home directory (where they start after login)
│    │  │ │  └─ User comment/description (GECOS field)
│    │  │ └─ Group ID (primary group)
│    │  └─ User ID (unique number for this user)
│    └─ Password (x = stored in /etc/shadow file)
└─ Username (login name)

Common users:
root      uid=0   (system administrator)
daemon    uid=1   (system account for services)
nobody    uid=65534 (unprivileged user)
_username uid=1000+ (regular user accounts)
```

## Practice Commands

### Viewing Files
```bash
# Create test files
echo "Line 1" > /tmp/file1.txt
echo "Line 2" >> /tmp/file1.txt
echo "Line 3" >> /tmp/file1.txt
echo "Line 4" >> /tmp/file1.txt
echo "Line 5" >> /tmp/file1.txt

# Practice viewing
cat /tmp/file1.txt                # Display all lines
head -n 2 /tmp/file1.txt          # First 2 lines
tail -n 2 /tmp/file1.txt          # Last 2 lines
head -n 3 /tmp/file1.txt | tail -n 1  # Get middle line

# Combining files
echo "File 2" > /tmp/file2.txt
cat /tmp/file1.txt /tmp/file2.txt # Display both
cat /tmp/file1.txt /tmp/file2.txt > /tmp/combined.txt  # Combine
```

### Analyzing System Files
```bash
# View /etc/passwd
cat /etc/passwd                   # Show all users
head -5 /etc/passwd               # Show first 5 users
wc -l /etc/passwd                 # Count total users

# View /etc/hosts
cat /etc/hosts                    # Show hostname mappings
head /etc/hosts                   # Show first entries

# View configuration files
less /etc/ssh/sshd_config         # SSH configuration
less /etc/apt/sources.list        # Package sources (Ubuntu)

# View system information
cat /proc/cpuinfo                 # CPU information
cat /proc/meminfo                 # Memory information
```

## Key Takeaways

**When to use each command:**
- **cat**: Quick view, combining files, small files
- **head**: See beginning, check file format, see first entries
- **tail**: See end, watch logs with `-f`, last entries
- **less**: Large files, comfortable reading, search capability
- **more**: Simple viewing, older systems

**File viewing strategy:**
1. Unknown size? Use `head` first to preview
2. Large file? Use `less` or `more`
3. Want to combine? Use `cat` with `>`
4. Want last lines? Use `tail`
5. Want specific range? Use `head | tail`

## Safe Practice Steps
1. Create test files: `echo "content" > /tmp/test.txt`
2. Practice cat: `cat /tmp/test.txt`
3. Practice head/tail: `head -n 3 /tmp/test.txt`
4. Practice less: `less /tmp/test.txt` (press q to quit)
5. Combine files: `cat file1.txt file2.txt > combined.txt`
6. Analyze passwd: `head /etc/passwd` and `tail /etc/passwd`
7. Count lines: `wc -l /etc/passwd`
8. Search in less: `less /etc/passwd` then `/root` to find root user

## Resources to Use
- Bash manual: `man cat`, `man head`, `man tail`, `man less`, `man more`
- Linux man pages
- Test with real system files (/etc/passwd, /etc/hosts)

## /etc/passwd Analysis Challenge
```bash
# Try these commands and understand the output:
cat /etc/passwd                   # See all users
head /etc/passwd                  # See first users
tail /etc/passwd                  # See last users
grep root /etc/passwd             # Find root user
grep -v root /etc/passwd          # Find non-root users
wc -l /etc/passwd                 # Count total users
```

## Struggle Points


## Notes
- Use `less` for large files (better than `more`)
- `cat` can be inefficient for very large files
- `tail -f` is powerful for watching log files
- Combine commands: `head -n 5 file.txt | tail -n 1` gets line 5
- `/etc/passwd` shows all users on the system
- Regular users typically have uid >= 1000
- System services have uid < 100
- Don't edit /etc/passwd directly - use `passwd` command
