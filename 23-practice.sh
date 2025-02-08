#!/bin/bash


LOGS_FOLDER="var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGFILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER



USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_ROOT() {

    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run the cript with user priveleges $N" | tee -a $LOGFILE

    fi
}

USAGE(){
    echo "$R USAGE:: $N Expected Inputs sudo sh 16-redirectors.sh package1 package2.."
}



VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is.... $R FAILED $N" | tee -a $LOGFILE
    else
        echo -e "$2 is... $G SUCCESS $N" | tee -a $LOGFILE
    fi
}

echo "Script started executing at: $(date)" &>>LOGFILE | tee -a $LOGFILE
CHECK_ROOT
if [ $# -eq 0 ]
then
    USAGE
fi

for package in $@
do
    dnf list installed $package -y &>>$LOGFILE
    if [ $? -ne 0]
    then 
        echo echo "$package is not installed, going to install it.."| tee -a $LOGFILE
        dnf install $package -y
        VALIDATE $? "Installing $package"
    else
         echo -e "$package is already $Y installed..nothing to do $N" | tee -a $LOGFILE

    fi

done



