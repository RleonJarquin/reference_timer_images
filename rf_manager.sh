#!/bin/bash

# Declaration of variables 
IMAGE_PATH=$1
NUM_IMAGES=$2
MINUTES_PER_IMAGE=$3

if [ $# -lt 3 ]; then 
    echo "Usage: $0 <IMAGE_PATH> <NUM_IMAGES> <MINUTES_PER_IMAGE>"
    exit 1 
fi

# Check if Image path is a proper directory
if [ ! -d "$IMAGE_PATH" ]; then
    echo "$IMAGE_PATH is not a proper directory."   
    exit 1
fi

# Check that NUM_IMAGE and MINUTES_PER_IMAGE is a numerical value 
if [[ ! "$NUM_IMAGES" =~ ^[0-9]+$ ]]; then 
    echo "$NUM_IMAGES is not a numerical value."
    exit 1 
fi

if [[ ! "$MINUTES_PER_IMAGE" =~ ^[0-9]+$ ]]; then 
    echo "$MINUTES_PER_IMAGE is not a numerical value."
    exit 1 
fi

# Finding the image paths and redirecting output to txt file 
find "$IMAGE_PATH" -iregex "^.*\.\(jpg\|jpeg\|png\|gif\|bmp\|svg\)$" | shuf | head --lines="$NUM_IMAGES" > "IMAGE_PATHS.txt"

# Looping through the image paths and displaying the reference
IMG_FILE="IMAGE_PATHS.txt"
MAX_IMAGES=$(wc -l "IMAGE_PATHS.txt" | awk '{print $1}')
CURR_IMAGE=1

# While the current image is less than or equal to 
while [ $((CURR_IMAGE)) -le $((MAX_IMAGES)) ]; do
    echo "am in LOOP"
    # Find the current image path
    CURR_IMAGE_PATH=$(sed -n "${CURR_IMAGE}p" $IMG_FILE)

    # Executing the image viewer 
    feh --scale-down "$CURR_IMAGE_PATH" &
    FEH_PID=$!
    sleep "${MINUTES_PER_IMAGE}s"

    # Killing the image viewer and updating the CURR_IMAGE
    kill $FEH_PID
    CURR_IMAGE=$((CURR_IMAGE+1))
done 

echo "Finished with session!"

exit 0
