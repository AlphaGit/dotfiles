#!/bin/bash
download_icloud_folder() {
    # Retrieve the first parameter as the folder to download
    local folder="$1"

    # Check that the parameter is not empty and that the folder exists
    if [ -z "$folder" ] || [ ! -d "$folder" ]; then
        echo "The folder \"$folder\" does not exist"
        return 1
    fi

    find "$folder" -type f -exec brctl download "{}" \;
}

# Check if the script was invoked directly: ZSH
if [ -n "$ZSH_EVAL_CONTEXT" ] && [ "${ZSH_EVAL_CONTEXT}" = "toplevel" ]; then
    download_icloud_folder "$@"
fi

# Check if the script was invoked directly: BASH
if [ -n "$BASH_SOURCE" ] && [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    download_icloud_folder "$@"
fi
