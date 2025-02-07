#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0"


CHECK_ROOT() {
    if [ $USERID -ne 0 ]
    then 
        echo "Root priveleges Requried"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is... $R FAILED $N"  #$N normal color
        exit 1
    else
        echo -e "$2 is....$G SUCCESS $N"
    fi
}


CHECK_ROOT

dnf list installed gittt -y

VALIDATE $? "Listing Git"

if [ $? -ne 0 ]
then 
    echo "Git is not installed need to be installed"
    dnf install gittt -y
    VALIDATE $? "Installing git command"
else
    echo "Git is already installed"
fi