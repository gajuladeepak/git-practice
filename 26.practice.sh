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

while IFS= read -r file
do
    echo -e "$Y DELETING FILE $file $N"
    rm -rf $file
    echo -e "$G DELETING FILE $file $N"


done <<< $FILES