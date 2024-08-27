#!bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGFILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "$R Please run this script with root priveleges $N" &>>$LOGFILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N" &>>$LOGFILE
        exit 1
    else
        echo -e "$2 is... $G SUCCESS $N" &>>$LOGFILE
    fi
}
USAGE(){
    echo -e "$R USAGE:: $N sudo sh 16-redirectors.sh package1 package2.."
    exit 1
}

CHECK_ROOT
if [ $# -eq 0 ]
then
    USAGE
fi

for package in $@
do
    dnf list installed $package &>>$LOGFILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, going to install it.." &>>$LOGFILE
        dnf install $package -y
        VALIDATE $? "installing $package"
    else
        echo -e "$package is already $Y installed..nothing to do $N" &>>$LOGFILE
    fi
done