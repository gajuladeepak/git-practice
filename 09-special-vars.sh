#!bin/bash

echo "All varaibles passed to the script: $@"
echo "Number of variables passed: $#"
echo "Script name: $0"
echo "Home directory of current user: $HOME"
echo "PID of the current script": $$

sleep 100
echo "PID of last background command: $!" #enthaizxi mundhu background lo run chesina command's process instance id