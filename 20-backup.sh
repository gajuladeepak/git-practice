#!bin/bash

SOURCE_DIR=$1
DEST_DIR=$2

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

DAYS=${3:-14} # if $3 is empty, default is 14 days

USAGE(){
    echo -e "$R USAGE:: $N sh 20-backup.sh <source> <destination> <days(optional)>"
}

#cheking whether the source / destination are provided
if [ $# -lt 2 ]
then
    USAGE
fi