#!/bin/bash


export REMBER_CONFIG_FOLDER="$HOME/.config/rember"

create_config_folder() {
    mkdir -p "$REMBER_CONFIG_FOLDER"
}

create_deck() {

    subject_slug=$(echo "$1" | tr 'A-Z' 'a-z' | sed s/\ /_/g)

cat <<- EOF > ${REMBER_CONFIG_FOLDER}/${subject_slug}-$(uuidgen).yaml
subject: $1
cards:
EOF

    return $?
}


create_config_folder

if [ "$1" = "deck" ]; then

    case "$2" in
        new ) 
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

            create_deck "$4"

            echo "Deck created: $4"
            exit 0
        ;;

        list ) ;;
        delete ) ;;
        study ) ;;
    esac

fi

exit 0
