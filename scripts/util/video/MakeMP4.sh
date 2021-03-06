#!/bin/bash
# This script converts any video into Microsoft PowerPoint 2010 friendly WMV files
# The bitrate is preserved as in the original file
# [ USAGE ]: $0 <InputFile> <OutputFile>

if [ $# -ne 1 ]; then
    echo "[ USAGE ]: $0 <InputFile>"
    exit
fi

ffmpeg -i $1 -c:v libx264 -crf 20 $1.mp4
