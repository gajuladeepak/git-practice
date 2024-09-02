#!bin/bash

#usually logs will be in /var/log
#we need to create a folder in /var/log 
#let say i am creating a folder named (shell-script) in /var/log/shell-script
#file name should in specified foemat

#tee command(writs logs on multiple destinations)
#everytime checking the logs by navigating to logs file is hectic task
#so we use tee command to write logs on both terminal and logs
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGFILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER #if we give mkdir -p if it's created it will not show any error in terminal or if it is not created it will create a folder

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "$R Please run this script with root priveleges $N" | tee -a $LOGFILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N" | tee -a $LOGFILE
        exit 1
    else
        echo -e "$2 is... $G SUCCESS $N" | tee -a $LOGFILE
    fi
}

#while running the script we need to let the user to know what is happening 
USAGE(){
    echo -e "$R USAGE:: $N sudo sh 16-redirectors.sh package1 package2.."
    exit 1
}

echo "Script started executing at: $(date)" &>>LOGFILE | tee -a $LOGFILE
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
        echo "$package is not installed, going to install it.."| tee -a $LOGFILE
        dnf install $package -y &>>$LOGFILE
        VALIDATE $? "installing $package"
    else
        echo -e "$package is already $Y installed..nothing to do $N" | tee -a $LOGFILE
    fi
done