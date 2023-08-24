
generate_deck_id() {

    local last_id_created=$(yq '.last_id_created' $REMBER_CONFIG_FOLDER/"$REMBER_CONFIG_FILE_NAME")
    local new_id=$(( last_id_created+=1 ))

    yq -iy ".last_id_created = $new_id" "$REMBER_CONFIG_FOLDER/"$REMBER_CONFIG_FILE_NAME""
    
    printf "%d" $new_id
}

create_deck() {

    local subject_slug=$(echo "$1" | tr 'A-Z' 'a-z' | sed s/\ /_/g)

cat <<- EOF > ${REMBER_CONFIG_FOLDER}/${subject_slug}.yaml
id: $(generate_deck_id)
subject: $1
cards:
EOF

}

check_deck_subject() {
    if [ "$1" != "--subject" ]; then
        printf "Missing '--subject' option.\n"
        printf "Example: --subject \"C programming\"\n"
        return 1
    fi
    
    if [ -z "$2" ]; then
        printf "Missing string for --subject option.\n"
        printf "Example: --subject \"C programming\"\n"
        return 1
    fi

    return 0
}

list_decks() {
    for deck_filename in $(ls "$REMBER_CONFIG_FOLDER")
    do
        id=$(yq ".id" "$REMBER_CONFIG_FOLDER/$deck_filename") &&
        subject=$(yq ".subject" "$REMBER_CONFIG_FOLDER/$deck_filename") &&
        printf "ID: %d\tDeck Subject: %s\n" "$id" "$subject"

        if [ "$?" -ne 0 ]; then
            printf "rember: error on listing decks"
            return 1
        fi

    done

   return 0
}

delete_deck() {
    if [ -z $1 ] || [[ ! $1 =~ ^-?[0-9]+$ ]]; then
        printf "Is required a valid ID for deleting a deck.\n"
        printf "Example: 'deck delete 34'\n"
        return 1
    fi

    for deck_filename in $(ls "$REMBER_CONFIG_FOLDER")
    do
        if [ $1 -eq $(yq ".id" "$REMBER_CONFIG_FOLDER/$deck_filename") ]; then
            rm "$REMBER_CONFIG_FOLDER/$deck_filename" &&

            if [ "$?" -ne 0 ]; then
                printf "rember: error deleting deck.\n"
                return 1
            fi

            printf "rember: deck deleted\n"
            return 0
        fi
    done

    printf "rember: deck not found\n"

    return 1    
}


