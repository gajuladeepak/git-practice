SOURCE_DIR="/home/ec2-user/logs"
R="\e[31m"
Y="\e[33m"
G="\e[32m"
N="\e[0m"



if [ -d $SOURCE_DIR ]
then
    echo -e "$G $SOURCE_DIR Exists $N"
else
    echo -e "$R $SOURCE_DIR does not Exists $N"
    exit 1
    
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "$FILES"

if [ -z $FILES ]
then 
    echo -e "$Y There are no files greater than 14 days $N"
    exit
else
    echo -e "$G Files are found $N"
fi

while IFS= read -r file
do
    echo -e "$Y DELETED FILE $file $N"
    rm -rf $file
    echo -e "$G DELETED FILE $file $N"


done <<< $FILES