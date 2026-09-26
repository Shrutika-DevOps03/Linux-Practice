## DATE command Basic :
```
# Display current date/time
date                              # Full date and time
date +"%Y-%m-%d"                  # 2026-09-26 (YYYY-MM-DD)
date +"%Y%m%d"                    # 20260926 (YYYYMMDD)
date +"%Y-%m-%d_%H-%M-%S"        # 2026-09-26_08-38-35 (with time)
date +"%s"                        # Unix timestamp (seconds since 1970)

# Common date formats
date +"%A"                        # Full day name (Monday)
date +"%B"                        # Full month name (September)
date +"%Y-%m-%d %H:%M:%S"        # 2026-09-26 08:38:35

->
Sat Sep 26 08:38:35 UTC 2026
2026-09-26
20260926
2026-09-26_08-38-35
1790411915
date
Saturday
September
2026-09-26 08:38:35
```

## Using Dates in Variables
```
#!/bin/bash
# Stores date in variable for use in script

today=$(date +"%Y-%m-%d")
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
filename="backup_$today.tar.gz"
backup_dir="backup_$timestamp"

echo "Backup directory: $backup_dir"
echo "Backup file: $filename"

->
Backup directory: backup_2026-09-26_08-44-21
Backup file: backup_2026-09-26.tar.gz
```
































