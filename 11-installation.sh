#!/bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Root priveleges Requried"
    exit 1
fi

dnf list installed git -y

if [ $? -ne 0 ]
then 
    echo "Git is not installed need to be installed"
    dnf install git -y
    if [ $? -ne 0 ]
    then 
        echo "Git installation is failed... Try again"
    else
        echo "Git installation is successfull"
    fi
else
    echo "Git is already installed"
fi