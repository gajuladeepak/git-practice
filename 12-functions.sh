#!/bin/bash
USERID=$(id -u)


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
        echo "$2 is...FAILED"
        exit 1
    else
        echo "$2 is....SUCCESS"
    fi
}


CHECK_ROOT

dnf list installed git -y

VALIDATE $? "Listing Git"

if [ $? -ne 0 ]
then 
    echo "Git is not installed need to be installed"
    dnf install git -y
    VALIDATE $? "Installing git command"
else
    echo "Git is already installed"
fi