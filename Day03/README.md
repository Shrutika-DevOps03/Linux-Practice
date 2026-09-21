# Day 3: Master File Permissions

Time Spent: 45 minutes
Difficulty: Beginner

## Today's Learning
- Understand rwx permissions (read, write, execute)
- Numeric permission system (755, 644, 777, etc.)
- Symbolic permission system (u, g, o, a)
- Change permissions with `chmod` command
- Change ownership with `chown` command
- Interpret permission output from `ls -l`

## Understanding Permissions Basics
```
-rwxr-xr-x  1  user  group  4096  Sep 17 10:30  file.txt
│││││││││  │  ────  ─────
│││││││││  └─ Link count
│││││││││
└─ File type: - (regular file), d (directory), l (link)
 ├─ Owner permissions:   rwx (read, write, execute)
 ├─ Group permissions:   r-x (read, execute only)
 └─ Other permissions:   r-x (read, execute only)

Permission Values:
r (read)    = 4
w (write)   = 2
x (execute) = 1
```

## Commands to Practice
```
# VIEW PERMISSIONS
ls -l file.txt                    # See detailed permissions
stat file.txt                     # Show all file info

# CHMOD - NUMERIC MODE (most common)
chmod 755 file.txt               # rwxr-xr-x (standard executable)
chmod 644 file.txt               # rw-r--r-- (standard file)
chmod 777 file.txt               # rwxrwxrwx (full access - avoid!)
chmod 700 file.txt               # rwx------ (owner only)
chmod 600 file.txt               # rw------- (owner read/write only)

# CHMOD - SYMBOLIC MODE
chmod u+x file.txt               # Add execute for owner
chmod g-w file.txt               # Remove write from group
chmod o-r file.txt               # Remove read from others
chmod a+r file.txt               # Add read for all
chmod u=rwx,g=rx,o=rx file.txt  # Set exact permissions

# CHMOD - DIRECTORY PERMISSIONS
chmod 755 directory/              # Standard directory
chmod 700 directory/              # Private directory

# CHOWN - CHANGE OWNERSHIP
chown newuser file.txt            # Change owner
chown newuser:newgroup file.txt   # Change owner and group
chown -R newuser directory/       # Recursive for directory
sudo chown root file.txt          # Need sudo for most changes

# HELPFUL VIEWING
ls -lh                            # List with human-readable sizes
ls -ld directory/                 # Show directory permissions
stat -c '%A %U:%G %n' file.txt   # Show perms, owner, group, name
```

## Permission Calculation Guide
```
755 = rwxr-xr-x
  7 (owner):   4+2+1 = rwx (read, write, execute)
  5 (group):   4+0+1 = r-x (read, execute)
  5 (other):   4+0+1 = r-x (read, execute)

644 = rw-r--r--
  6 (owner):   4+2+0 = rw- (read, write)
  4 (group):   4+0+0 = r-- (read only)
  4 (other):   4+0+0 = r-- (read only)

777 = rwxrwxrwx (DANGEROUS - everyone can do everything)
700 = rwx------ (owner only - secure)
```

## Practice Environment
- Create test files: `touch /tmp/testfile.txt`
- Create test directory: `mkdir /tmp/testdir`
- Use `ls -l` after each change to see results
- Never change system files or directories

## Key Takeaways
- **755**: Standard for executable files and directories
- **644**: Standard for regular files (read-only for others)
- **777**: Security risk - avoid unless absolutely necessary
- **700**: Private - only owner can access
- **chmod**: Changes permissions, not ownership
- **chown**: Changes owner and group (usually needs sudo)

## Safe Practice Steps
1. Create test file: `touch /tmp/perm_test.txt`
2. View current permissions: `ls -l /tmp/perm_test.txt`
3. Practice numeric chmod: `chmod 644 /tmp/perm_test.txt`
4. View and verify: `ls -l /tmp/perm_test.txt`
5. Try symbolic: `chmod u+x /tmp/perm_test.txt`
6. Verify again: `ls -l /tmp/perm_test.txt`
7. Practice on directory: `mkdir /tmp/perm_dir` then `chmod 755 /tmp/perm_dir`
8. Test understanding by calculating permissions of random numbers

## Resources to Use
- Bash manual: `man chmod`, `man chown`, `man ls`
- Interactive permission calculator
- Linux man pages documentation
- Practice changing permissions on test files only

## Common Permission Scenarios
```
Script file (executable):      755 or 755
Regular data file:            644 or 640
Private file (owner only):    600
Directory (standard):         755
Private directory:            700
Shared directory:             775
Configuration file:           600 or 640
Public readable file:         644
```

## Struggle Points
None

## Notes
- Use `stat` command to understand permission breakdown
- Never use 777 in production - it's a security risk
- Permissions on directories control access to files inside
- Changing ownership usually requires `sudo`
- Always verify with `ls -l` after making changes
- Use symbolic mode when modifying specific permissions
- Use numeric mode when setting exact permissions
