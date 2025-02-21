#!bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOG_FOLDER

USERID=$(id -u)

CHECK_ROOT() {
    if [ $USERID -ne 0 ]
    then
        echo -e "$Y Please Provide Root Previligies $N" | tee -a $LOG_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is....... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is........ $G SUCCESS $N" | tee -a $LOG_FILE
    fi
}


CHECK_ROOT

dnf list installed mysql &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "mysql is not installed... Installing it"
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "Installing Mysql"
else
    echo "Git is already installed" | tee -a $LOG_FILE
fi


    



