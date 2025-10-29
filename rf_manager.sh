#!/bin/bash

# Declaration of variables 
IMAGE_PATH=$1
NUM_IMAGES=$2
TIME_PER_IMAGE=$3
RESTART=true


if [ $# -le 3 ]; then 
    echo "Usage: $0 [OPTION] <IMAGE_PATH> <NUM_IMAGES> <TIME_PER_IMAGE>"
    exit 1 
fi


# Start of the loop 
while $RESTART; do
    
done

exit 0
