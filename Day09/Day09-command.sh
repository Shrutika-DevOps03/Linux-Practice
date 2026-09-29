## Basic Pipe Practice

# Simple pipes

cat data.txt | wc -l 		# count lines
# -> 7

cat data.txt | grep "apple" 	# find apple
#-> apple 10
#    apple 12
#    apple 9

cat data.txt | sort		# sort content
#->
#apple 10
#apple 12
#apple 9
#banana 3
#banana 5
#cherry8
#date 7

cat data.txt | sort -k2 -rn	# sort by second column (descending)
# ->
#apple 12
#apple 10
#apple 9
#date 7
#banana 5
#banana 3
#cherry8

# Count with grep

grep "ERROR" test.log | wc -l 
#-> 3

cat data.txt | grep "apple" | wc -l 
#-> 3

## Output Redirection Practice 

# Create files with redirection

cat data.txt > data_copy.txt 	# Copy file
#-> ls
#Day09-command.sh  README.md  data.txt  data_copy.txt  scripts,notes}  test.log

cat data.txt | grep "apple" > apple.txt 
#-> ls
#3                 README.md  data.txt       ls              test.log
#Day09-command.sh  apple.txt  data_copy.txt  scripts, notes}

# Append to files

echo "New Lines"  >> data.txt 
#-> cat data.txt
#apple 10
#banana 5
#cherry8
#apple 12
#banana 3
#date 7
#apple 9
#New Lines

grep "ERROR" test.log >> errors.log
#-> ls
#3                 README.md  cat       data_copy.txt  ls              test.log
#Day09-command.sh  apple.txt  data.txt  errors.log     scripts,notes}

#-> cat errors.log
#2026-09-23 10:15:45 ERROR: Database connection failed
#2026-09-23 10:16:22 ERROR: File not found
#2026-09-23 10:17:00 ERROR: Backup failed

## Multiple Pipe Practice

# 2-command pipelines

cat data.txt | grep "apple" 
#-> apple 10
 #  apple 12
 #  apple 9


cat data.txt | sort -k2
#->
#cherry8
#apple 10
#apple 12
#banana 3
#banana 5
#date 7
#apple 9
#New Lines

# 3-command pipelines

cat data.txt | grep "apple" | awk '{print $2}'
#-> 10
#12
#9

cat test.log | grep "ERROR" | cut -d: -f2
#-> f2
#15
#16
#17

# 4+ command pipelines

cat data.txt | grep "apple" | awk '{sum+=$2} END {print sum}'
#-> 31

cat test.log | cut -d' ' -f3 | grep -o "[A-Z]*" | sort | uniq -c | sort -rn
#->  1 File
 #     1 Database
  #    1 Backup

# Complex Worlflow Practice

# Find, count, and sort

cat test.log | cut -d' ' -f3 | grep -o "[A-Z]*" | sort | uniq -c | sort -rn
#-> 3 INFO
 #     3 ERROR
  #    1 WARNING
# Extract third column → find words → count → sort by frequency

# Pipe with error handling

cat test.log | grep "ERROR" | cut -d: -f2 > errors.txt 2> parse_errors.txt
#-> cat errors.txt
#15
#16
#17

# Write results to file

cat data.txt | sort -k2 -rn > sorted_data.txt
#-> cat sorted_data.txt
#apple 12
#apple 10
#apple 9
#date 7
#banana 5
#banana 3
#cherry8
#New Lines
