#!bin/bash

#i will create a source folder(app-logs) in /home/ec2-user/app-logs
#i will create a destination folder(backup) in /home/ec2-user/backup
# before running the script create log files in app-logs
#cd app-logs/
#touch -d 20240101 mysql.log


SOURCE_DIR=$1
DEST_DIR=$2
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

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
    exit 1
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

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)

echo "Files: $FILES"

if [ ! -z $FILES ] #true if files are empty, ! makes it false
then
    echo "Files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@ #here we are zipping all the files returned by find command and file name is ZIP_FILE

    #check if zip is successfully created or not
    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zipped files older than $DAYS"

        #remove the files after zipping
        while IFS= read -r file #IFS, internal field separator, empty it will ignore white spaces. -r is for not to ignore special characters like /
        do 
            echo "Deleting file: $file"
            rm -rf $file

        done <<< $FILES 
    else
        echo "Zipping the files is failed"
        exit 1
    fi
else
    echo "No old files than $DAYS"

fi

