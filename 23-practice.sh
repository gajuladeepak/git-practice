#!/bin/bash







USERID=$(id -u)

CHECK_ROOT() {

    if [ $USERID -ne 0 ]
    then
        echo "Please run the cript with user priveleges"

    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo "$2 is.... FAILED"
    else
        echo "$2 is... SUCCESS"
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



