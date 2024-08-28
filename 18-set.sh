#!/bin/bash

set -e # setting the automatic exit, if we get error

#set -ex #set -ex for debug

failure(){
    echo "Failed at: $1:$2"
}

trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR

echo "Hello World"

echooo "Hello World Failure"

echo "Hello World After Failure"