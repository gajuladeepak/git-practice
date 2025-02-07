#!/bin/bash
PERSON1=$1
PERSON2=$2

echo "$PERSON1:: Hi ${PERSON2}, How are you?"
echo "${PERSON2}:: Hello $PERSON1. I am fine. How are you doing?"
echo "$PERSON1:: I am doing good ${PERSON2}. What's going on?"
echo "${PERSON2}:: I started learning Shell Script $PERSON1"


#we are passing inputs from command line
#ssh 03-variables.sh ramesh suresh
#                      $1     $2
#passing from outside through args