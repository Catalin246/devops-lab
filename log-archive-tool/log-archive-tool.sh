#!/bin/bash

if [ -z "$1" ]; then
    echo "USAGE: log-archive <log-dir>"
    exit 1
fi

logs_dir="$1"

if ! [ -d "$logs_dir" ]; then
    echo "$logs_dir doesn't exist"
    exit 1
fi

if ! [ -r "$logs_dir" ]; then
    echo "Current user $USER has no permission to read the files in directory $logs_dir"
    exit
fi

basename_dir=$(basename "$logs_dir")
current_date=$(date +'%Y%m%d')
current_time=$(date +'%H%M%S')
logs_archive_name="$basename_dir"_archive_"$current_date"_"$current_time".tar.gz

tar -czvf "$logs_archive_name" "$logs_dir"

echo "The logs archive $logs_archive_name was created"
