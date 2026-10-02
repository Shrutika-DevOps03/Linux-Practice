## Create Test Scripts

# Create age validation

cat > ~/age_validator.sh << 'EOF'
#!/bin/bash
read -p "Enter your age: " age

if ! [[ $age =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid age"
    exit 1
fi

if [ $age -lt 18 ]; then
    echo "You are a minor"
elif [ $age -lt 65 ]; then
    echo "You are an adult"
else
    echo "You are a senior"
fi
EOF

chmod +x ~/age_validator.sh

-> ls
Day12-command.sh
README.md
Script_1.sh
Script_2.sh
Script_3.sh
Script_4.sh
Script_5.sh
age_validator.sh
scripts,notes}

-> sh age_validation.sh
Enter your age: 23
You are an adult

-> sh age_validator.sh
Enter your age: 75
You are a senior

## Test String Comparisons

# Create script
cat > test_strings.sh << 'EOF'
#!/bin/bash
name="Alice"
city="London"

if [ "$name" = "Alice" ]; then
    echo "Name is Alice"
fi

if [ -n "$city" ]; then
    echo "City is not empty: $city"
fi

if [[ "$name" =~ ^A ]]; then
    echo "Name starts with A"
fi
EOF

chmod +x test_strings.sh
test_strings.sh

-> ls
Day12-command.sh
README.md
Script_1.sh
Script_2.sh
Script_3.sh
Script_4.sh
Script_5.sh
age_validator.sh
scripts,notes}
test_strings.sh

-> sh test_strings.sh
Name is Alice
City is not empty: London
