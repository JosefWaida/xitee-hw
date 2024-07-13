#!/bin/bash

# Define directories and image names
declare -A directories
directories=(
    ["ansible-vm"]="ansible-vm"
    ["backup-vm"]="backup-vm"
)

# Iterate over directories and build Docker images
for dir in "${!directories[@]}"; do
    echo "Building Docker image for $dir..."
    cd "$dir" || { echo "Failed to cd into $dir"; exit 1; }
    docker build -t "${directories[$dir]}" .
    if [ $? -ne 0 ]; then
        echo "Failed to build Docker image for $dir"
        exit 1
    fi
    cd - || { echo "Failed to cd back to the original directory"; exit 1; }
done

echo "All Docker images built successfully."
