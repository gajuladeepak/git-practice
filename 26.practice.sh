#!bin/bash





LOG_FOLDER="var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME-$TIMESTAMP"
mkdir -p $LOG_FOLDER


USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

 
CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$Y PLease provide root previliges $N" | tee -a $LOG_FILE

    fi

}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 command is..... $R FAILED $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 command is..... $R SUCCESS $N" | tee -a $LOG_FILE
    fi
}


CHECK_ROOT

CHECK_INPUT(){
    echo -e " $R PROPER INPUT SHOULD BE GIVEN $N"
    echo -e "$Y INPUT FORMAT:: sh 26.practice <package1> <package2> $N"
    exit 1
}

if [ $# -eq 0 ]
then
    CHECK_INPUT
fi


for package in $@
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo -e "$package is not installled.. $Y INSTALLING $N" | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "INSTALLING $package"
    else

        echo -e "$package is $Y ALREADY INSTALLED $N" | tee -a $LOG_FILE
    
    fi

done



