#!/bin/bash

# Define an array of commands to execute
commands=(
"curl -s https://nos.nl/weer | grep regen"
"curl -s https://nos.nl/weer | html2text -utf8 | awk '/Weerbericht/,/Weerfoto/'"
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
