#!/bin/bash

USERID=$(id -u) #to get direct user id we use id -u

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
else
    echo "Git is already installed"
fi



#to check the user id we use command: id
#if it's root user it returns 0
#if it's not root user it returns other than 0
