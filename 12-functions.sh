#!/bin/bash

USERID=$(id -u)

CHECK_ROOT(){
    if [ USERID -ne 0 ]
    then
        echo "please provide root preveliges"
    fi
}

VALIDATE() {
    if [ $1 -ne 0]
    then
        echo "$2 is... failed"
    else
        echo "$2 is... success"
    fi

}


CHECK_ROOT

dnf list installed git -y
VALIDATE $? "listing git"

if [ $? -ne 0 ]
then
    echo "Git is installed need to be installed"
    dnf install git -y
    VALIDATE $? "Installing git command"
else
    echo "Git is already installed"

fi



