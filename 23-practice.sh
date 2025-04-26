#!bin/bash

# SOURCE_DIR="/home/ec2-user/logs"

# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# N="\e[0m"

# if [ -d $SOURCE_DIR ]
# then
#     echo -e "$G Folder EXISTS $N"
# else
#     echo -e "$R Folder is not found $N"
#     exit 1

# fi

# FILES=$(find $SOURCE_DIR -name "*log" -mtime +14)
# echo $FILES


# while IFS= read -r file
# do
#     echo "Deleting the: $file"
#     rm -rf $file
#     echo "Deleted the $file"



# done <<< $FILES

# USERID=$(id -u)

# CHECK_ROOT() {
#     if [ $USERID -ne 0 ]
#     then
#         echo "Please provide root access"
#         exit 1

#     fi
# }

# VALIDATE() {
#     if [ $1 -ne 0 ]
#     then
#         echo "$2... is Failed"
#         exit 1
#     else
#         echo "$2... is Success"

#     fi
# }

# CHECK_ROOT


# for package in $@
# do
#     dnf list installed $package
#     if [ $? -ne 0 ]
#     then
#         echo "$package is not installed"
#         dnf install $package
#         VALIDATE $? $package
#     else
#         echo "$package is alreadyh installed"

#     fi



# done
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "Please run the script with root priveleges"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2.. is FAILED" | tee -a $LOG_FILE
    else
        echo "$2.. is SUCCESS" | tee -a $LOG_FILE
    fi
}

USAGE(){
    echo "USAGE:: sudo sh 16-redirectors.sh package1 package2"
}

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

CHECK_ROOT


if [ $# -eq 0 ]
then
    USAGE
fi


for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, need to install" | tee -a $LOG_FILE
        dnf install $package &>>$LOG_FILE
        VALIDATE $? "Installing Package"
    else
        echo "$package is already installed" | tee -a $LOG_FILE

    fi

done

