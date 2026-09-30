## Create Test Environment

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

		## SED Practice : ##


# Simple replacement

sed 's/apple/orenge/' test_data.txt
->
orenge 10 red
banana 5 yellow
orenge 12 red
cherry 8 red
banana 3 yellow

sed 's/apple/orenge/g' test_data.txt
->
orenge 10 red
banana 5 yellow
orenge 12 red
cherry 8 red
banana 3 yellow

# Case-insensitive

sed 's/APPLE/orenge/i' test_data.txt
:<< 'COMMENT'
->
orenge 10 red
banana 5 yellow
orenge 12 red
cherry 8 red
banana 3 yellow
'COMMENT'

# In-place with backup

sed -i.bak 's/apple/orenge/g' test_data.txt
-> ls
Day10-command.sh  config.txt  scripts,notes}  test_data.txt.bak
README.md         people.csv  test_data.txt

# Remove comments

sed '/^#/d' config.txt
->
host=localhost
port=5432
admin=true
debug=false

# Remove blank lines

sed '/^$/d' config.txt
->
# Database Configuration
host=localhost
port=5432
# User Settings
admin=true
# Debug Mode
debug=false

# Multiple operations

sed -e '/^#/d' -e '/^$/d' config.txt
->
host=localhost
port=5432
admin=true
debug=false

		## AWK Practice : ##

# Extract columns

awk '{print $1}' test_data.txt
->
orenge
banana
orenge
cherry
banana

awk '{print $1, $3}' test_data.txt
->
orenge red
banana yellow
orenge red
cherry red
banana yellow

# CSV Processing

awk -F',' '{print $1}' people.csv
->
name
Alice
Bob
Charlie
Diana
Eve

awk -F',' '{print $1, $3}' people.csv
->
name city
Alice New York
Bob London
Charlie Paris
Diana Tokyo
Eve Berlin

# Filter rows

awk '$2 > 10' test_data.txt
->
orenge 12 red

awk '$3 == "red"' test_data.txt
->
orenge 10 red
orenge 12 red
cherry 8 red

# Skip header

awk -F',' 'NR>1 {print $1}' people.txt
->
Alice
Bob
Charlie
Diana
Eve

# Calculate sum

awk '{sum += $2} END {print sum}' test_data.txt
->
38

# Count matches

awk '$3 == "red" {count ++} END {print count}' test_data.txt
->
3

		## Advanced Practice ##

# Replace and extract 

sed 's/apple/fruit/g' test_data.txt | awk '{print $1, $2}'
->
orenge 10
banana 5
orenge 12
cherry 8
banana 3

# Process CSV with condition

awk -F',' 'NR>1 && $2 > 25' people.csv
->
Alice,28,New York
Bob,35,London
Diana,31,Tokyo
Eve,26,Berlin

# Find average value

awk -F',' 'NR>1 {sum+=$2; count++} END {print "Average age:", sum/count}' people.csv
->
Average age: 28.4

# Extract and format

$ awk -F',' 'NR==1 {next} {printf "%-10s %3d %s\n", $1, $2, $3}' people.csv
->
Alice       28 New York
Bob         35 London
Charlie     22 Paris
Diana       31 Tokyo
Eve         26 Berlin

# Multiple filters

$ awk '$2 > 5 && $3 == "red"' ~/test_data.txt
->
orenge 10 red
orenge 12 red
cherry 8 red
