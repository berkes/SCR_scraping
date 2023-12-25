#!/bin/bash

# Define an array of commands to execute
commands=(
"curl -s nu.nl/verkeer" 
)

# Loop through the commands
for cmd in "${commands[@]}"; do
    # Display the command
    echo "Command: $cmd"
    
    # Ask for user input
    read -p "Run it? (Y/N): " choice
    
    # Check the choice
    if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
        # Execute the command
        eval "$cmd"
    elif [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
        echo "Skipping command: $cmd"
    else
        echo "Invalid choice, skipping command: $cmd"
    fi
done
