#!bin/bash

SOURCE_DIR="/home/ec2-user/logs"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ -d $SOURCE_DIR ]
then
    echo -e "$G Folder EXISTS $N"
else
    echo -e "$R Folder is not found $N"
    exit 1

fi

FILES=$(find $SOURCE_DIR -name "*log" -mtime +14)
echo $FILES


while IFS= read -r file
do
    echo "Deleting the: $file"
    rm -rf $file
    echo "Deleted the $file"



done <<< $FILES

