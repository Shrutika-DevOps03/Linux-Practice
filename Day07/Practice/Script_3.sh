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
