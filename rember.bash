#!/bin/bash

# rember deck new --subject "computer network"

export REMBER_CONFIG_FOLDER="$HOME/.config/rember"

create_config_folder() {
    mkdir -p "$REMBER_CONFIG_FOLDER"
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

    subject_slug=$(echo $4 | tr 'A-Z' 'a-z' | sed s/\ /_/)

    cat <<- EOF > ${REMBER_CONFIG_FOLDER}/${subject_slug}-$(uuidgen).yaml
subject: $4
cards:
EOF

fi

exit 0
