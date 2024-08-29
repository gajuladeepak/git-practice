#!/bin/bash

SOURCE_DIR=/home/ec2-user/logs
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR $G Exists $N"
else
    echo "$SOURCE_DIR $R does not exist $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files: $FILES"

#Do not the word "line" it is reserved word
while IFS= read -r file #IFS, internal field separator, empty it will ignore white spaces. -r is for not to ignore special characters like /
do 
    echo "Deleting file: $line"
    rm -rf $line

done <<< $FILES #3 < indicates that giving FIlEs as input and also indiacte read the file line by line
