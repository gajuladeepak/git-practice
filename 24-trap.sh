#!/bin/bash

failure(){
    echo "Failed at: $1:$2"
}

trap 'failure "${LINE_NO}" "${BASH_COMMAND}"' ERR




# failure(){
#     echo "Failed at: $1:$2"
# }

# trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR