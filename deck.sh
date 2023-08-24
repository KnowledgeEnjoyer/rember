
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
