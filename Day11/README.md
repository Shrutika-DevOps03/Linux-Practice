# Day 11: Master User and Group Management

**Time Spent:** 30 min
**Difficulty:** Beginner

## Today's Learning
- Understand Linux users and groups system
- Create users with `useradd` command
- Create groups with `groupadd` command
- Add users to groups with `usermod` command
- View users in `/etc/passwd` file
- View password hashes in `/etc/shadow` (requires sudo)
- Understand user and group IDs (UID, GID)
- Manage group membership
- Delete users and groups safely

## Understanding Users and Groups

### What are Users and Groups?
```
Users: Individual accounts that can log in and own files
Groups: Collections of users sharing permissions on files/directories

Example:
- User "alice" is a person who can log in
- Group "developers" contains alice, bob, charlie
- File owned by "developers" group gives alice, bob, charlie access
```

### User ID (UID) and Group ID (GID)
```bash
UID = User ID - Unique number for each user (0=root, 1-999=system, 1000+=regular users)
GID = Group ID - Unique number for each group (0=root, 1-999=system, 1000+=regular)
```

## Understanding /etc/passwd

### /etc/passwd File Structure
```
/etc/passwd contains user information (readable by everyone)

Format: username:password:uid:gid:comment:home:shell

Example line:
alice:x:1001:1001:Alice Smith:/home/alice:/bin/bash
│      │   │    │    │             │             │
│      │   │    │    │             │             └─ Login shell
│      │   │    │    │             └─ Home directory
│      │   │    │    └─ Comment/description (GECOS field)
│      │   │    └─ Primary group ID (GID)
│      │   └─ User ID (UID)
│      └─ Password (x = stored in /etc/shadow)
└─ Username (login name)

Common system users:
root:x:0:0:root:/root:/bin/bash          (uid=0, most powerful)
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin  (no login)
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin  (unprivileged)
```

### View /etc/passwd
```bash
# View all users
cat /etc/passwd

# View specific user
grep "^alice" /etc/passwd

# Count users
wc -l /etc/passwd

# Show users with login shell
grep -v "nologin$" /etc/passwd

# Show regular users (uid >= 1000)
awk -F: '$3 >= 1000 {print}' /etc/passwd

# View with columns
cat /etc/passwd | head -5
```

## Understanding /etc/shadow

### /etc/shadow File Structure
```
/etc/shadow contains password hashes (REQUIRES SUDO to read)

Format: username:password_hash:last_change:min_age:max_age:warning:inactive:expire:reserved

Example line:
alice:$6$abcd1234$efgh5678:19230:0:99999:7:::::
│     │                    │      │ │     │
│     │                    │      │ │     └─ Warning period (days)
│     │                    │      │ └─ Minimum age (days)
│     │                    │      └─ Maximum age (days before change required)
│     │                    └─ Days since password last changed
│     └─ Password hash (encrypted)
└─ Username (matches /etc/passwd)

$ = Hashed (bcrypt, SHA-512, etc.)
* or ! = Account locked
!! = Password never set
```

### View /etc/shadow (requires sudo)
```bash
# View all user passwords (RESTRICTED - requires sudo)
sudo cat /etc/shadow

# View specific user (requires sudo)
sudo grep "^alice" /etc/shadow

# View password expiration info
sudo chage -l username

# Show users with no password set
sudo awk -F: '$2 == "!!" || $2 == "!" {print $1}' /etc/shadow

# Show locked accounts
sudo awk -F: '$2 ~ /^!/ {print $1}' /etc/shadow
```

## USERADD - Create Users

### Basic useradd Syntax
```bash
# Create user with defaults
sudo useradd username              # Creates user with system defaults

# Create user with home directory
sudo useradd -m username           # -m: create home directory

# Create with specific UID
sudo useradd -u 1050 username      # -u: specify UID

# Create with specific primary group
sudo useradd -g groupname username # -g: specify primary group

# Create with specific home directory
sudo useradd -d /custom/path username  # -d: custom home path

# Create with specific shell
sudo useradd -s /bin/bash username # -s: set login shell

# Create with comment
sudo useradd -c "Full Name" username  # -c: set user comment (GECOS)

# Create with expiry date
sudo useradd -e 2027-12-31 username  # -e: account expiration date
```

### Common useradd Options
```bash
# Comprehensive user creation
sudo useradd \
  -m \                            # Create home directory
  -s /bin/bash \                  # Set shell to bash
  -c "John Doe" \                 # Add comment
  -g users \                      # Primary group
  -G sudo,docker \                # Additional groups
  john                            # Username

# Quick creation with defaults
sudo useradd -m alice             # Create alice with home directory

# System user (no login)
sudo useradd -r -s /usr/sbin/nologin myservice
```

### Real-World Examples
```bash
# Create developer user
sudo useradd -m -s /bin/bash -c "Developer User" -G docker,sudo dev1

# Create service account (no login shell)
sudo useradd -r -s /usr/sbin/nologin postgres

# Create with home in custom location
sudo useradd -m -d /srv/alice alice

# Create multiple users
for i in {1..5}; do
  sudo useradd -m -s /bin/bash user$i
done
```

## GROUPADD - Create Groups

### Basic groupadd Syntax
```bash
# Create group with auto-assigned GID
sudo groupadd developers      # Creates group with next available GID

# Create group with specific GID
sudo groupadd -g 2000 developers  # -g: specify GID

# Create system group
sudo groupadd -r systemgroup  # -r: create as system group

# View created groups
grep "developers" /etc/group

# List all groups
cat /etc/group

# Count groups
wc -l /etc/group
```

### /etc/group File Structure
```
Format: groupname:password:gid:members

Example:
developers:x:1001:alice,bob,charlie
│          │   │    │
│          │   │    └─ Members (comma-separated usernames)
│          │   └─ Group ID (GID)
│          └─ Group password (usually x or *, rarely used)
└─ Group name

Common system groups:
root:x:0:
wheel:x:10:                    # admin/sudo group (varies by distro)
sudo:x:27:                     # sudo access group
docker:x:999:alice,bob         # docker access for alice and bob
```

## USERMOD - Modify Users

### Add User to Group
```bash
# Add user to single group (primary group becomes this)
sudo usermod -g newgroup username    # -g: change primary group

# Add user to additional groups (keep existing)
sudo usermod -aG docker username     # -a: append, -G: groups
sudo usermod -aG sudo username       # Add to sudo group

# Add to multiple groups at once
sudo usermod -aG docker,sudo,users alice

# Show user's groups
groups username
id username                    # Show UID, GID, groups
```

### Other usermod Options
```bash
# Change home directory
sudo usermod -d /new/home username

# Change login shell
sudo usermod -s /bin/bash username

# Change username
sudo usermod -l newname oldname

# Lock account
sudo usermod -L username              # -L: lock (prefix password with !)

# Unlock account
sudo usermod -U username              # -U: unlock

# Set expiry date
sudo usermod -e 2027-12-31 username

# Change comment
sudo usermod -c "New Name" username
```

## Viewing and Managing Users

### List Users and Groups
```bash
# All users
cat /etc/passwd

# Regular users only (uid >= 1000)
awk -F: '$3 >= 1000 {print $1}' /etc/passwd

# Users with login shell
grep -v "nologin$" /etc/passwd | cut -d: -f1

# All groups
cat /etc/group

# Groups with members
awk -F: '$4 != "" {print}' /etc/group

# Groups for specific user
groups username
id username
```

### User Information Commands
```bash
# Show user details
id alice                        # Show UID, GID, groups
groups alice                    # Show group membership
finger alice                    # Show user info (if installed)

# Show logged-in users
who                            # Currently logged in users
w                              # Who and what they're doing
last                           # Login history

# Show password info
sudo chage -l alice            # Password expiration info
sudo chage -l root             # Root password status
```

## Deleting Users and Groups

### Delete User
```bash
# Delete user (keep home directory)
sudo userdel username

# Delete user and home directory
sudo userdel -r username              # -r: remove home and mail

# Safe deletion (preserve files, change ownership)
sudo userdel -f username

# View home directory before deleting
sudo ls -la /home/username
```

### Delete Group
```bash
# Delete group
sudo groupdel groupname

# Check if group exists
grep "^groupname:" /etc/group

# Show group members before deletion
getent group groupname
```

## Practice Commands

### Create Test Users and Groups
```bash
# Create users
sudo useradd -m -s /bin/bash -c "Test User 1" testuser1
sudo useradd -m -s /bin/bash -c "Test User 2" testuser2
sudo useradd -m -s /bin/bash -c "Test User 3" testuser3

# Create groups
sudo groupadd testgroup1
sudo groupadd testgroup2
sudo groupadd developers

# Verify creation
grep "^test" /etc/passwd
grep "^test" /etc/group
```

### Add Users to Groups
```bash
# Add testuser1 to testgroup1
sudo usermod -aG testgroup1 testuser1

# Add testuser2 to multiple groups
sudo usermod -aG developers,testgroup2 testuser2

# Verify group membership
groups testuser1
id testuser2

# Show group members
grep "^testgroup1:" /etc/group
```

### View User Information
```bash
# View /etc/passwd
grep "testuser" /etc/passwd

# View /etc/shadow (requires sudo)
sudo grep "testuser" /etc/shadow

# Show user details
id testuser1

# Show all groups
cat /etc/group | grep test
```

### Modify Users
```bash
# Change user's shell
sudo usermod -s /bin/bash testuser1

# Change user's comment
sudo usermod -c "Updated Test User" testuser1

# Add to additional group
sudo usermod -aG testgroup2 testuser1

# Verify changes
id testuser1
groups testuser1
```

### Cleanup - Delete Test Users
```bash
# Delete user (keep home directory)
sudo userdel testuser1

# Delete user and remove home directory
sudo userdel -r testuser2
sudo userdel -r testuser3

# Delete groups
sudo groupdel testgroup1
sudo groupdel testgroup2
sudo groupdel developers

# Verify deletion
grep "test" /etc/passwd        # Should show nothing
grep "test" /etc/group         # Should show nothing
```

## Key Takeaways

**/etc/passwd Structure:**
- Username:Password(x):UID:GID:Comment:Home:Shell
- Contains user info (readable by all)
- UID 0 = root, 1-999 = system, 1000+ = regular users
- `x` means password is in /etc/shadow

**/etc/shadow Structure:**
- Username:PasswordHash:LastChange:MinAge:MaxAge:Warning:Inactive:Expire
- Contains encrypted passwords (sudo required to read)
- `!` or `*` = locked account
- `!!` = password never set

**User Creation (useradd):**
- `-m` - Create home directory
- `-s` - Set login shell
- `-c` - Add comment/full name
- `-g` - Primary group
- `-G` - Additional groups
- `-u` - Specify UID
- `-e` - Expiration date

**Group Creation (groupadd):**
- `-g` - Specify GID
- `-r` - Create system group
- Groups stored in /etc/group

**User Modification (usermod):**
- `-aG groups` - Add to groups (append)
- `-g group` - Change primary group
- `-s /shell` - Change login shell
- `-L` - Lock account
- `-U` - Unlock account

## Safe Practice Steps
1. View /etc/passwd: `cat /etc/passwd`
2. View /etc/shadow: `sudo cat /etc/shadow`
3. Create test user: `sudo useradd -m -s /bin/bash testuser`
4. Create test group: `sudo groupadd testgroup`
5. Add user to group: `sudo usermod -aG testgroup testuser`
6. Check user details: `id testuser`
7. View group membership: `groups testuser`
8. Modify user: `sudo usermod -c "New Name" testuser`
9. Delete test user: `sudo userdel -r testuser`
10. Delete test group: `sudo groupdel testgroup`

## Resources to Use
- Bash manual: `man useradd`, `man groupadd`, `man usermod`
- File documentation: `man passwd`, `man shadow`, `man group`
- System administration guides
- Practice on test system only
- Never delete system users/groups

## Important Files

```bash
/etc/passwd      # User database (world-readable)
/etc/shadow      # Password hashes (root-only)
/etc/group       # Group database (world-readable)
/etc/gshadow     # Group passwords (root-only, rarely used)
/etc/sudoers     # Sudo configuration (use visudo to edit)
```

## Security Considerations

```bash
# Do NOT edit /etc/passwd or /etc/shadow directly - use usermod/useradd
# Do NOT edit /etc/group directly - use groupmod/groupadd
# Always use SUDO for user/group management
# Never create uid=0 or gid=0 except for root
# Back up /etc/passwd, /etc/shadow, /etc/group before major changes
# Test on non-production system first
# Use strong passwords when creating users
# Review sudo group membership carefully (sudo gives root access)
```

## Common User Management Workflows

```bash
# Create developer with docker and sudo access
sudo useradd -m -s /bin/bash -c "Developer" -G docker,sudo dev1

# Create service account (no login)
sudo useradd -r -s /usr/sbin/nologin myservice

# Lock/unlock user account
sudo usermod -L username      # Lock
sudo usermod -U username      # Unlock

# Add multiple users to group
for user in alice bob charlie; do
  sudo usermod -aG developers $user
done

# Show all admins (sudo group members)
getent group sudo
```

## Struggle Points
1. Forgetting sudo for User/Group Commands
Beginners run useradd alice or groupadd developers without sudo, getting "Permission denied" error and thinking the command is broken. They don't realize user/group management requires root privileges, and every command needs sudo useradd, sudo groupadd, etc.

2. Using -g Instead of -aG - Accidentally Removes User from All Groups
Students add user to a group with usermod -g docker alice expecting to add docker, but -g replaces the primary group entirely, removing alice from other groups. They should use -aG docker alice (append to groups), not -g (change primary group only).

## Notes
- Always use `sudo` for user/group management
- Use `useradd -m` to create home directory
- Use `usermod -aG` to add to additional groups (append, don't replace)
- Never directly edit /etc/passwd or /etc/shadow - use proper tools
- UID 0 (root) and UID 1-999 (system) - avoid these for regular users
- GID 1000+ typically for regular user groups
- Lock accounts with `usermod -L` instead of deleting
- Use `visudo` to edit /etc/sudoers, never edit directly
- Test user creation on non-production systems first
- Back up user/group files before making changes
- `groups` command shows groups user belongs to
- `id` shows UID, GID, and all group memberships
