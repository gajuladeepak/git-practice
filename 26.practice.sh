#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


SOURCE_DIR=/home/ec2-user/logs

if [ -d $SOURCE_DIR ]
then
    echo "File Exists"
else
    echo "File do not exist"
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo $FILES

while IFS= read -r file
do
    echo $file

done <<< $FILES