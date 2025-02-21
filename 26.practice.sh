#!bin/bash

# LOG_FOLDER="/var/log/shell-script"
# SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
# TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
# LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
# echo $LOG_FILE
# mkdir -p $LOG_FOLDER


# USERID=$(id -u)
# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# N="\e[0m"

 
# CHECK_ROOT(){
#     if [ $USERID -ne 0 ]
#     then
#         echo -e "$Y PLease provide root previliges $N" | tee -a $LOG_FILE

#     fi

# }

# VALIDATE(){
#     if [ $1 -ne 0 ]
#     then
#         echo -e "$2 is..... $R FAILED $N" | tee -a $LOG_FILE
#         exit 1
#     else
#         echo -e "$2 is..... $G SUCCESS $N" | tee -a $LOG_FILE
#     fi
# }


# CHECK_ROOT

# CHECK_INPUT(){
#     echo -e " $R PROPER INPUT SHOULD BE GIVEN $N"
#     echo -e "$Y INPUT FORMAT:: sh 26.practice <package1> <package2> $N"
#     exit 1
# }

# if [ $# -eq 0 ]
# then
#     CHECK_INPUT
# fi


# for package in $@
# do
#     dnf list installed $package &>>$LOG_FILE
#     if [ $? -ne 0 ]
#     then
#         echo -e "$package is not installled.. $Y INSTALLING $N" | tee -a $LOG_FILE
#         dnf install $package -y &>>$LOG_FILE
#         VALIDATE $? "INSTALLING $package"
#     else

#         echo -e "$package is $Y ALREADY INSTALLED $N" | tee -a $LOG_FILE
    
#     fi

# done

# SOURCE_DIR="/home/ec2-user/logs"

# if [ -d $SOURCE_DIR ]
# then
#     echo "$SOURCE_DIR EXISTS"
# else
#     echo "$SOURCE_DIR does not EXISTS"
#     exit 1
# fi

# FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)
# echo "Files: $FILES"

# while IFS= read -r file
# do
#     echo "Deleting the file: $file"
#     rm -rf $file

# done <<< $FILES


SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

USAGE(){
    echo "USAGE:: sh.26-practice <source-dir> <destination-dir> <days(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$Y THE $SOURCE_DIR DOES NOT EXIST $N"
    exit 1
fi


if [ ! -d $DEST_DIR ]
then
    echo -e "$Y THE $DEST_DIR DOES NOT EXIST $N"
    exit 1
fi

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)

echo "$FILES"

if [ -z $FILES ]
then
    echo "There are no old files than $DAYS"
    exit 1
else
    echo "Files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $(SOURCE_DIR) -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@

    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zipped files older than $DAYS"
        while IFS= read -r file
        do
            echo "DELETING FILE: $file"
            rm -rf $file

        done <<< $FILES
    else
        echo "Zipping the files is failed"
        exit 1

    fi


fi

