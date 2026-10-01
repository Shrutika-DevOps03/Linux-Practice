## Create Test Users and Groups

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
->
susudo usermod -aG developers,testgroup2 testuser2do usermod -aG developers,testgroup2 testuser2testuser1:x:1002:1002:Test User 1:/home/testuser1:/bin/bash
testuser2:x:1003:1003:Test User 2:/home/testuser2:sudo usermod -aG developers,testgroup2 testuser2/bin/bash
testuser3:x:1004:1004:Test User 3:/home/testuser3:/bin/bash

grep "^test" /etc/group
->
testuser1:x:1002:
testuser2:x:1003:
testuser3:x:1004:
testgroup1:x:1005:
testgroup2:x:1006:

## Add Users to Groups

# Add testuser1 to testgroup1

sudo usermod -aG testgroup1 testuser1
->
groups testuser1
testuser1 : testuser1 testgroup1

# Add testuser2 to multiple groups

sudo usermod -aG developers, testgroup2 testuser2
->
id testuser2
uid=1003(testuser2) gid=1003(testuser2) groups=1003(testuser2),1006(testgroup2),1007(developers)

# Show group members

grep "^testgroup1:" /etc/group
->
testgroup1:x:1005:testuser1

## View User Information

# View /etc/passwd

grep "testuser" /etc/passwd
->
testuser1:x:1002:1002:Test User 1:/home/testuser1:/bin/bash
testuser2:x:1003:1003:Test User 2:/home/testuser2:/bin/bash
testuser3:x:1004:1004:Test User 3:/home/testuser3:/bin/bash

# View /etc/shadow

sudo grep "testuser" /etc/shadow
->
testuser1:!:20726:0:99999:7:::
testuser2:!:20726:0:99999:7:::
testuser3:!:20726:0:99999:7:::

# Show user details

id testuser1
->
uid=1002(testuser1) gid=1002(testuser1) groups=1002(testuser1),1005(testgroup1)

# Show all groups

cat /etc/group | grep test
->
testuser1:x:1002:
testuser2:x:1003:
testuser3:x:1004:
testgroup1:x:1005:testuser1
testgroup2:x:1006:testuser2
developers:x:1007:testuser2

## Modify Users

# Change user's comment

sudo usermod -c "Updated Test User"  testuser1
->
grep "testuser" /etc/passwd
testuser1:x:1002:1002:Updated Test User:/home/testuser1:/bin/bash

# Add to additional group
sudo usermod -aG testgroup2 testuser1
->
groups testuser1
testuser1 : testuser1 testgroup1 testgroup2

## Cleanup -Delete Test Users

# Delete user

sudo userdel testuser1
->
grep "test" /etc/passwd
testuser2:x:1003:1003:Test User 2:/home/testuser2:/bin/bash
testuser3:x:1004:1004:Test User 3:/home/testuser3:/bin/bash

# Delete user and remove home Directory

sudo userdel -r testuser2
sudo userdel -r testuser3
-> grep "test" /etc/passwd
Show Nothing

# Delete groups

sudo groupdel testgroup1
sudo groupdel testgroup2
sudo groupdel developers
-> grep "test" /etc/group
Show Nothing
