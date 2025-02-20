#!bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

CHECK_ROOT() {
    if [ $USERID -ne 0 ]
        echo "Please Provide Root Previligies"
        exit 1

    fi
}

VALIDATE(){
    if [ $1 -ne 0]
        echo "$2 is....... $R FAILURE $N"
        exit 1
    else
        echo "$2 is........ $G SUCCESS $N"
    fi
}


CHECK_ROOT

dnf list installed mysql  -y
VALIDATE $? "Listing mysql"

if [ $? -ne 0]
    echo "Git is not installed... Installing it"
    dnf install mysql -y
    VALIDATE $? "Installing Mysql"
else
    echo "Git is already installed"
fi


    



