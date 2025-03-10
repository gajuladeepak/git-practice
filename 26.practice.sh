#!bin/bash

SOURCE_DIR=$1
DEST_DIR=$2

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

DAYS=${3:-14}

if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$SOURCE_DIR does not exist"
fi


if [ ! -d $DEST_DIR ]
then 
    echo -e "$DEST_DIR does not exist"
fi

USAGE() {
    echo "Please provide valid inputs"
    echo -e "$Y 26.practice.sh <source-dir> <dest-dir> $N"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo $Files

if [ -z $FILES ]
then
    echo -e "$Y No Files are exist greater than $DAYS $N"

else
    echo "$FILES are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*log" -mtime +14 | zip "$ZIP_FILE" -@

    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zpping files older than $DAYS"
        while IFS= read -r file
        do

            echo -e "$Y Deleting the file: $file $N"
            rm -rf $file
            echo -e "$G Deleted the file $file $N"

        done <<< $FILES
    else
        echo -e "$R Zipping the files is failed $N"
        exit 1
    fi

        

fi

