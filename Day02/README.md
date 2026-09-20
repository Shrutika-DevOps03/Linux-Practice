## Day 2: Master File Operations

Time Spent: 45 minutes
Difficulty: Beginner

## Today's Learning
- Learn cp command (copy files and directories)
- Learn mv command (move and rename files)
- Learn rm command (delete files safely)
- Understanding flags: -r

## Commands to Practice

# CP - Copy Files
cp file.txt file_copy.txt          # Copy a file
cp -r directory/ directory_copy/   # Copy directory recursively
cp file.txt /path/to/destination/  # Copy to another locatiomv oldname.txt newname.txt         # Rename a file

# MV - Move/Rename Files
mv oldname.txt newname.txt         # Rename a file
mv file.txt /path/to/destination/  # Move file to another directory
mv file.txt ../                    # Move to parent directory

# RM - Remove Files (USE CAUTION)
rm file.txt                        # Delete a file
rm -i file.txt                     # Interactive mode (asks before deleting)
rm -r directory/                   # Remove directory recursively
rm -v file.txt                     # Verbose (shows what's being deleted)

# DANGER - Never use without understanding:
rm -rf /                           # DO NOT RUN - deletes everything!

## Practice Environment
- Create test files first before practicing deletions
- Never practice on real files

## Key Takeaways
- cp: Safe - creates a copy, doesn't remove original
- mv: Dangerous - no copy, just moves (can overwrite)
- rm: Most dangerous - permanent deletion, no undo, no trash

## Safe Practice Steps
1. Create test directory: `mkdir /tmp/practice`
2. Create test files: `touch /tmp/practice/test1.txt`
3. Always use interactive mode when learning: `rm -i`

## Resources to Use
- Bash manual: `man cp`, `man mv`, `man rm`
- GNU Core Utilities documentation
- Practice safe deletion patterns

## Struggle Points
None - Fundamentals were clear

## Notes
- Never use `rm -rf` without fully understanding what you're deleting
- `mv` can overwrite existing files silently - be careful
- `cp` is the safest to practice with first
