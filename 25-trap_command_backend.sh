#!bin/bash

LOGS_FOLDER="/var/log/expense"
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
        echo -e "$R Please run this script with root priveleges $N" | tee -a $LOGFILE
        exit 1
    fi
}

VALIDATE(){
    echo -e "$R Error at Line NO:$1 $N" | tee -a $LOGFILE
    echo -e "$R Command Failed: $2 $N" | tee -a $LOGFILE
}

trap 'VALIDATE "${LINE_NO}" "${BASH_COMMAND}"' ERR

echo "Script started executing at: $(date)" | tee -a $LOGFILE
CHECK_ROOT

dnf module disable nodejs -y &>>$LOGFILE


dnf module enable nodejs:20 -y &>>$LOGFILE


dnf install nodejs -y &>>$LOGFILE


id expense &>>$LOGFILE
if [ $? -ne 0 ]
then
    echo -e "expense user not exists... $G Creating User $N"
    useradd expense &>>$LOGFILE
   
else
    echo -e "Expence user already exists... $Y SKIPPING $N"
fi

mkdir -p /app


curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE


cd /app
rm -rf /app/* #remove the existing code
unzip /tmp/backend.zip &>>$LOGFILE


npm install &>>$LOGFILE
cp /home/ec2-user/expence-shell/backend.service  /etc/systemd/system/backend.service

# load the data before running backend

dnf install mysql -y &>>$LOGFILE


mysql -h mysql.deepakaws.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOGFILE


systemctl daemon-reload &>>$LOGFILE


systemctl enable backend &>>$LOGFILE


systemctl restart backend &>>$LOGFILE

