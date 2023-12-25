#!/bin/bash

# Define an array of commands to execute
commands=(
"curl -s https://nos.nl/weer | grep regen"
"curl -s https://nos.nl/weer | html2text -utf8 | awk '/Weerbericht/,/Weerfoto/'"
"wget --directory-prefix /tmp/ --spider --recursive --level 1 https://linuxnijmegen.nl/"
"wget --mirror --convert-links --adjust-extension --no-parent --directory-prefix=./data https://linuxnijmegen.nl/"
"rg 'Presentatie door: ' ./data/linuxnijmegen.nl/onderwerpen/ | html2text -utf8 | grep 'Presentatie door: ' | cut -d : -f2 | sort | uniq -c | sort -h -r"
'cat ./data/linuxnijmegen.nl/onderwerpen/*.html | hxnormalize -x | hxselect -s "\n" -c "div.uk-panel:nth-child(2)"'
)

index=0

# Loop through the commands
while [ $index -lt ${#commands[@]} ]; do
    # Display the command
    echo -e "\e[1mCommand:\e[0m ${commands[$index]}"
    
    # Ask for user input
    read -p "Run it? [Y]es, [N]o, [P]revious, [I]nformation: " choice
    
    # Check the choice
    if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
        # Execute the command
        eval "${commands[$index]}"
        ((index++)) # Move to the next command
    elif [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
        echo "Skipping command: ${commands[$index]}"
        ((index++)) # Move to the next command
    elif [ "$choice" == "P" ] || [ "$choice" == "p" ]; then
        if [ $index -gt 0 ]; then
            ((index--)) # Go back to the previous command
        else
            echo "Already at the beginning."
        fi
    elif [ "$choice" == "I" ] || [ "$choice" == "i" ]; then
      # Open explainshell in Firefox with the encoded command
      encoded_cmd=$(echo -n "${commands[$index]}" | jq -s -R -r @uri)
      firefox "https://explainshell.com/explain?cmd=$encoded_cmd"
    else
        echo "Invalid choice, please enter Y, N, or P."
    fi

    # Add a new line and a visual separator
    echo -e "\n----------------------------------------\n"
done
