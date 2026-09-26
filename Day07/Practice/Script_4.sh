# Create complete system
cat > ~/backup_system.sh << 'EOF'
#!/bin/bash
# Complete backup system

backup_base="$HOME/backups"
source_dir="$HOME/test_data"

backup() {
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    backup_dir="$backup_base/backup_$timestamp"
    
    echo "Creating backup: $backup_dir"
    read -p "Continue? (y/n): " -n 1 confirm
    echo ""
    
    if [ "$confirm" = "y" ]; then
        mkdir -p "$backup_base"
        cp -r "$source_dir" "$backup_dir"
        echo "✓ Backup created"
    else
        echo "✗ Canceled"
    fi
}

list() {
    echo "========== BACKUPS =========="
    ls -lhd "$backup_base"/backup_* 2>/dev/null || echo "No backups found"
}

# Menu
case "${1:-menu}" in
    backup|b) backup ;;
    list|l) list ;;
    *)
        echo "Usage: $0 {backup|list}"
        ;;
esac
EOF

chmod +x ~/backup_system.sh
~/backup_system.sh backup
~/backup_system.sh list
