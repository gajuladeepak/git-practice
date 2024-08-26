#!bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root priveleges"
    exit 1
fi

dnf list installed gittt
if [ $? -ne 0 ]
then
    echo "Git is not installed, going to install it.."
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Git installation is not success...check it"
    else
        echo "Git installation is success"
    fi
else
    echo "Git is already installed, nothing to do.."
fi