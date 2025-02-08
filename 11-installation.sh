#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Root Preveliges...REQURIED"
    exit 1
fi


dnf list installed git -y

if [ $? -ne 0 ]
then
    echo "Git is not installed...NEED TO BE INSTALLED"
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Git Installation is failed... TRY AGAIN"
        exit 1

    else
        echo "Git installation is Successfull"

    fi
fi
