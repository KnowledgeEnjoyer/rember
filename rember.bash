#!/bin/bash


export REMBER_CONFIG_FOLDER="$HOME/.config/rember"
export REMBER_CONFIG_FILE_NAME=".rember.yaml"

create_config_folder() {
    mkdir -p "$REMBER_CONFIG_FOLDER"

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
    
    echo $new_id
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

        list )
            for deck_filename in $(ls "$REMBER_CONFIG_FOLDER")
            do
                id=$(yq ".id" "$REMBER_CONFIG_FOLDER/$deck_filename")
                subject=$(yq ".subject" "$REMBER_CONFIG_FOLDER/$deck_filename")

            echo -e "ID: $id\tDeck Subject: $subject"

            done

        ;;

        delete ) ;;
        study ) ;;
    esac

fi

exit 0
