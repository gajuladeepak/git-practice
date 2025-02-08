#!bin/bash

#usually logs will be in /var/log for linux
#we need to create a folder in /var/log 
#let say i am creating a folder named (shell-script) in /var/log/shell-script
#file name should in specified foemat

#tee command(writs logs on multiple destinations)
#everytime checking the logs by navigating to logs file is hectic task
#so we use tee command to write logs on both terminal and logs
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER  # -p if we use it it checks if its is already it will not throw an error if it is not instlled it will install it

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run this script with root priveleges $N" &>>$LOG_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N" &>>$LOG_FILE
        exit 1
    else
        echo -e "$2 is... $G SUCCESS $N" &>>$LOG_FILE
    fi
}


#while running the script we need to let the user to know what is happening 
USAGE(){
    echo -e "$R USAGE:: $N sudo sh 16-redirectors.sh package1 package2 ..."
    exit 1
}

echo "Script started executing at: $(date)" &>>$LOG_FILE

CHECK_ROOT

if [ $# -eq 0 ]
then
    USAGE
fi

for package in $@ # $@ refers to all arguments passed to it
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, going to install it.." &>>$LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y installed..nothing to do $N" &>>$LOG_FILE
    fi
done