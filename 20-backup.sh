#!bin/bash

#i will create a source folder(app-logs) in /home/ec2-user/app-logs
#i will create a destination folder(backup) in /home/ec2-user/backup

SOURCE_DIR=$1
DEST_DIR=$2

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

DAYS=${3:-14} # if $3 is empty, default is 14 days

USAGE(){
    echo -e "$R USAGE:: $N sh 20-backup.sh <source> <destination> <days(optional)>"
}

#cheking whether the source / destination are provided
if [ $# -lt 2 ]
then
    USAGE
fi

#checking whether the source directory exists or not

if [ ! -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR does not exist....Please check"
fi

if [ ! -d $DEST_DIR ]
then 
    echo "$DEST_DIR does not exist....Please check"
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)

if [ -n $FILES ]
then
    echo "Files are found"
else
    echo "No old files than $DAYS"

fi

