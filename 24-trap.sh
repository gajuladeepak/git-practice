#!/bin/bash

failure(){
    echo "Failed at: $1:$2"
}

trap 'failure "${LINE_NO}" "${BASH_COMMAND}"' ERR

echo "Hello World"

echooo "Hello World Failure"

echo "Hello World After Failure"


# failure(){
#     echo "Failed at: $1:$2"
# }

# trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR