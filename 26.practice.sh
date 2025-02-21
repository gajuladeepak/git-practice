#!bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/expense-shell"
SCRIPT_NAME=$(echo $0)

USERID=$(id -u)

CHECK_ROOT() {
    if [ $USERID -ne 0 ]
    then
        echo "Please Provide Root Previligies"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is....... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 is........ $G SUCCESS $N"
    fi
}


CHECK_ROOT

dnf list installed mysql
VALIDATE $? "Listing mysql"

if [ $? -ne 0]
then
    echo "mysql is not installed... Installing it"
    dnf install mysql -y
    VALIDATE $? "Installing Mysql"
else
    echo "Git is already installed"
fi


    



