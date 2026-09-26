## Practice 2: Simple Backup Script

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
