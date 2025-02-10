#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


SOURCE_DIR=$1
DEST_DIR= $2
DAYS=${3:-14}
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

# if [ -d $SOURCE_DIR ]
# then
#     echo "$SOURCE_DIR $G Exists $N"
# else
#     echo "$SOURCE_DIR $R does not exist $N"
# fi

# FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
# echo $FILES

# while IFS= read -r file
# do
#     echo $file
#     rm -rf $file
#     echo "Deleting File: $file"

# done <<< $FILES

USAGE(){
    echo -e "$R USAGE:: $N sh.practice <Source dir> <Destination Dir> <days(Optional)>"
}

if [ $# -lt 2 ]
then
    USAGE
    exit 1
fi

if [ ! -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR does not exist....Please Check"
    exit 1
fi


if [ ! -d $DEST_DIR ]
then 
    echo "$DEST_DIR does not exist....Please Check"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime $DAYS)
echo $FILES

if [ -z $FILES ]
then
    echo "Files are not present greater than $DAYS"

else
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime $DAYS | zip "$ZIP_FILE" -@

    if [ -f $ZIP_FILE ]
    then
        echo " Successfully zipped files older than $DAYS"
        while IFS= read -r file
        do
            echo "Deleting File: $file"
            rm -rf $file

        done <<< $FILES

    else
    echo "Zipping the files is failed"
fi
