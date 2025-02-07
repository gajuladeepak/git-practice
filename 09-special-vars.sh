#!bin/bash

echo "All varaibles passed to the script: $@"
echo "Number of variables passed: $#"
echo "Script name: $0"
echo "Current Working directory: $PWD"
echo "Home directory of current user: $HOME"
echo "PID of the current script": $$

sleep 100 &
echo "PID of last background command: $!" #enthaku mundhu background lo run chesina command's process instance id