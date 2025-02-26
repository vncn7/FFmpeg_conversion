#!/bin/bash

#################################################
# Video Converter Script                        #
#################################################
# Usage:                                        #
# converter_h264.sh -f FILENAME [-o OUTPUT]      #
#################################################

# Function to print script usage
print_usage() {
    echo "Usage: $0 -f FILENAME [-o OUTPUT]"
    echo "Converts video to H.264 format using FFmpeg."
    echo ""
    echo "Options:"
    echo "  -f,--file FILENAME: Input video file to convert"
    echo "  -o,--output OUTPUT: Specify the output filename (optional)"
    echo "  -h,--help: Display this help message"
    echo ""
}

# Default input filename and output filename
filename=""
output_filename=""

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            print_usage
            exit
            ;;
        -f|--file)
            shift
            filename="$1"
            ;;
        -o|--output)
            shift
            output_filename="$1"
            ;;
    esac
    shift
done

# Check if the input file exists
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' does not exist."
    exit 1
fi

# If the output filename is not provided, use the default filename with ".mp4" extension
if [ -z "$output_filename" ]; then
    output_filename="${filename%.*}.mp4"
fi

# Convert the video using ffmpeg
ffmpeg -i "$filename" -c:v h264_qsv -b:v 6M -c:a aac -threads 12 "$output_filename"

echo "Video successfully converted to H.264 in $output_filename."

