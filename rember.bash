#!/bin/bash


export REMBER_CONFIG_FOLDER="$HOME/.config/rember"
export REMBER_CONFIG_FILE_NAME=".rember.yaml"

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

generate_deck_id() {

    local last_id_created=$(yq '.last_id_created' $REMBER_CONFIG_FOLDER/"$REMBER_CONFIG_FILE_NAME")
    local new_id=$(( last_id_created+=1 ))

    yq -iy ".last_id_created = $new_id" "$REMBER_CONFIG_FOLDER/"$REMBER_CONFIG_FILE_NAME""
    
    printf "%d" $new_id
}

create_deck() {

    subject_slug=$(echo "$1" | tr 'A-Z' 'a-z' | sed s/\ /_/g)

cat <<- EOF > ${REMBER_CONFIG_FOLDER}/${subject_slug}.yaml
id: $(generate_deck_id)
subject: $1
cards:
EOF

}


create_config_folder

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
            printf "rember: Command not recognized\n"
            exit 1
        ;;
    esac

elif [ "$1" = "card" ]; then
    printf "Card options\n"

else
    printf "rember: Command not recognized\n"
    exit 1
fi



exit 0
