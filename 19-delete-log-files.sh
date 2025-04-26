#!/bin/bash


#first we need to create "logs' folder
#if the folder exist we don't need to create the folder again
#before running create log files in /home/ec2-user/logs
#touch -d 202040101 mysql.log #here we are creating with back dates therefore we are using -d
#touch -d 20240101 git.log
SOURCE_DIR=/home/ec2-user/logs
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"


if [ -d $SOURCE_DIR ] #-d for directory(-d <path_of_directory>) if the directory exists it will show as exist 
then
    echo -e "$SOURCE_DIR $G Exists $N"
else
    echo -e "$SOURCE_DIR $R does not exist $N"
    exit 1
fi

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)
echo "Files: $FILES"

#Do not use the word "line" it is reserved word
while IFS= read -r file #IFS, internal field separator is empty, empty it will not ignore white spaces. -r is for not to ignore special characters like /
do 
    echo "Deleting file: $file"
    rm -rf $file

done <<< $FILES #3 < indicates that giving FIlEs as input and also indiacte read the file line by line
 

#crontab - we can schedule the script periodically
#to shecdule
#command: crontab -e
#editor will get opened
# * * * * * sh <full path of script>
# */2 * * * * /home/ec2-user/git-practice/19-delete-log-files.sh - place this line in editor to run the script for every one minute

#to check whether the crontab is running or not 
#cd /var/log/
#ls -l
#sudo tail -f cron


#while IFS= read -r file 
#============================
#  Line-by-Line Explanation:
# IFS= read -r file
# You're saying: "Read a line from input and store it in the variable file."
# IFS= (empty) means: "Don't split the line at all." So even if the filename has spaces or tabs, it keeps it as one piece.
# -r tells read: "Don't interpret backslashes (\) as escape characters."
# (e.g., \n won’t become a new line.)
#  This makes sure the entire line is treated exactly as-is, which is super important when filenames have spaces or special characters.