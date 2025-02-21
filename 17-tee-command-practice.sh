#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGs_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGs_FOLDER/$SCRIPT_NAME-$TIMESTAMP"

USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is... SUCCESS"
    else
        echo "$2 is... FAILURE"
    fi
}

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
        echo "Please provide root preveliges"
        exit 1
    fi
}

USAGE(){
    echo "USAGE:: sudo sh 16-redirectors.sh package1 package2.."
    exit 1
}

CHECK_ROOT

if [ $# -eq 0 ]
then
    USAGE
fi

for package in $@
do
    dnf list installed $package -y
    VALIDATE $? "list installed"
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, going to install it..."
        dnf install $package -y
        VALIDATE $? "installing $package"

done

