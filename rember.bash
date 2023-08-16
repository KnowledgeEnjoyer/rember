#!/bin/bash

# rember deck new --subject computer network
# rember deck new --subject "computer network"

REMBER_CONFIG_FOLDER="~/.config/rember"

create_config_folder() {
    mkdir -p "$REMBER_CONFIG_FOLDER"
}

check_existing_deck() {

}


create_config_folder

if [ "$1" = "deck" ] && [ "$2" = "new" ]; then
    echo "You entered command to create a new deck."

    if [ "$3" != "--subject" ]; then
        echo "Missing '--subject' option."
        echo "Example: --subject \"C programming\""
        exit 1
    fi

    if [ -z "$4" ]; then
        echo "Missing string for --subject option."
        echo "Example: --subject \"C programming\""
        exit 1
    fi

    check_existing_deck "name"

fi

exit 0
