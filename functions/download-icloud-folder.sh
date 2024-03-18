download-icloud-folder() {
    # Retrieve the first parameter as the folder to download
    local folder="$1"

    # Check that the parameter is not empty and that the folder exists
    if [ -z "$folder" ] || [ ! -d "$folder" ]; then
        echo "The folder does not exist"
        return 1
    fi

    find "$folder" -type f -exec brctl download "{}" \;
}