#!/bin/bash







USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_ROOT() {

    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run the cript with user priveleges $N"

    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is.... $R FAILED $N"
    else
        echo -e "$2 is... $G SUCCESS $N"
    fi
}

CHECK_ROOT

for package in $@
do
    dnf list installed $package -y
    VALIDATE $? "Installing $package"
    dnf install $package -y
    VALIDATE $? "Installing $package"

done



