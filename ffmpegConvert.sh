#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display error messages
error() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Function to display success messages
success() {
    echo -e "${GREEN}$1${NC}"
}

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    error "Usage: $0 <input_file> <output_file>"
fi

# tmp 

input_file="$1"
output_file="$2"

# Check if input file exists
[ -f "$input_file" ] || error "Input file does not exist"

# Perform the conversion
echo "Converting $input_file to $output_file..."
ffmpeg -i "$input_file" \
       -c:v h264_nvenc  \
       -preset p7 \
       -cq 19 \
       -maxrate 15M \ 
       -bufsize 30M \
       -c:a aac \
       -b:a 256k \
       -y
       "$output_file"

# Check if the conversion was successful
if [ $? -eq 0 ]; then
    success "Conversion completed successfully!"
else
    error "An error occurred during conversion"
fi