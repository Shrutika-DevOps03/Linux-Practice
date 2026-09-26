## Backup with Confirmation

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
