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
            if [ "$3" != "--subject" ]; then
                printf "Missing '--subject' option.\n"
                printf "Example: --subject \"C programming\"\n"
                exit 1
            fi
        
            if [ -z "$4" ]; then
                printf "Missing string for --subject option.\n"
                printf "Example: --subject \"C programming\"\n"
                exit 1
            fi

            create_deck "$4"

            printf "Deck created: %s\n" "$4"
            exit 0
        ;;

        list )
            for deck_filename in $(ls "$REMBER_CONFIG_FOLDER")
            do
                id=$(yq ".id" "$REMBER_CONFIG_FOLDER/$deck_filename")
                subject=$(yq ".subject" "$REMBER_CONFIG_FOLDER/$deck_filename")

                printf "ID: %d\tDeck Subject: %s\n" "$id" "$subject"
            done
            exit 0
        ;;

        delete ) 

            if [ -z $3 ] || [[ ! $3 =~ ^-?[0-9]+$ ]]; then
                printf "Is required a valid ID for deleting a deck.\n"
                printf "Example: 'deck delete 34'\n"
                exit 1
            fi

            for deck_filename in $(ls "$REMBER_CONFIG_FOLDER")
            do
                if [ $3 -eq $(yq ".id" "$REMBER_CONFIG_FOLDER/$deck_filename") ]; then
                    rm "$REMBER_CONFIG_FOLDER/$deck_filename"
                    printf "Deck deleted\n"
                    exit 0
                fi
            done

            printf "Deck not found\n"
            exit 1
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
