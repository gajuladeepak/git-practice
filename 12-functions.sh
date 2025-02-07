#!/bin/bash
USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "Command is...FAILED"
        exit 1
    else
        echo "Command is....SUCCESS"
    fi
}



if [ $USERID -ne 0 ]
then 
    echo "Root priveleges Requried"
    exit 1
fi

dnf list installed git -y

VALIDATE $?

# if [ $? -ne 0 ]
# then 
#     echo "Git is not installed need to be installed"
#     dnf install git -y
#     if [ $? -ne 0 ]
#     then 
#         echo "Git installation is failed... Try again"
#         exit 1
#     else
#         echo "Git installation is successfull"
#     fi
# else
#     echo "Git is already installed"
# fi