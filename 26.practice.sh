# SOURCE_DIR="/home/ec2-user/logs"
# R="\e[31m"
# Y="\e[33m"
# G="\e[32m"
# N="\e[0m"



# if [ -d $SOURCE_DIR ]
# then
#     echo -e "$G $SOURCE_DIR Exists $N"
# else
#     echo -e "$R $SOURCE_DIR does not Exists $N"
#     exit 1
    
# fi

# FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
# echo "$FILES"

# if [ -z $FILES ]
# then 
#     echo -e "$Y There are no files greater than 14 days $N"
#     exit
# else
#     echo -e "$G Files are found $N"
# fi

# while IFS= read -r file
# do
#     echo -e "$Y DELETED FILE $file $N"
#     rm -rf $file
#     echo -e "$G DELETED FILE $file $N"


# done <<< $FILES


SOURCE_DIR=$1
DEST_DIR=$2
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
DAYS=$(3:-14)

USAGE(){
    echo "Please provide source dir and destination dir"
    echo "USAGE:: sh practice.sh /home/ec2-user/app-logs /home/ec2-user/backup"
}

if [ $# -lt 2]
then 
    USAGE
    exit 1
fi

if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR... Does not exist"
    exit 1
fi


if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR... Does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "FILES: $FILES"

if [ -z $FILES ]
then
    echo "No old files older than $DAYS"
    exit 1
else
    echo "FILES are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +14 | zip $ZIP_FILE -@

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
fi

