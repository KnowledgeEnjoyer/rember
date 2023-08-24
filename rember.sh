#!/bin/bash


export REMBER_CONFIG_FOLDER="$HOME/.config/rember"
export REMBER_CONFIG_FILE_NAME=".rember.yaml"

source ./deck.sh


##
#
# REMBER SETUP
#
##

create_config_folder() {

    mkdir -p "$REMBER_CONFIG_FOLDER"

    if [ ! $? ]; then
        printf "Unable to create rember config folder.\n"
        exit 1
    fi

    if [ ! -f "$REMBER_CONFIG_FOLDER/"$REMBER_CONFIG_FILE_NAME"" ]; then

cat <<- EOF > "$REMBER_CONFIG_FOLDER/"$REMBER_CONFIG_FILE_NAME""
last_id_created: 0
EOF

    fi
}

create_config_folder


##
#
# REMBER COMMANDS AND OPTIONS
#
##


if [ "$1" = "deck" ]; then

    case "$2" in
        new ) 
            check_deck_subject "$3" "$4" &&
            create_deck "$4" &&
            printf "Deck created: %s\n" "$4"

            exit "$?"
        ;;

        list )
            list_decks 

            exit "$?"
        ;;

        delete ) 
            delete_deck "$3"

            exit "$?"
        ;;

        study ) ;;

        * ) 
            printf "rember: Command not recognized for deck\n"
            exit 1
        ;;
    esac

elif [ "$1" = "card" ]; then

    case "$2" in 
        add ) 
            
        ;;

        * ) 
            printf "rember: Command not recognized for card\n"
            exit 1
        ;;
    esac

else
    printf "rember: Command not recognized\n"
    exit 1
fi



exit 0
