which-branches() {
    # Displays the branches for which a particular commit has been made.

    # Usage:
    #   which-branches <commit>

    # Arguments:
    #   <commit> - The commit to check.

    # Output:
    #   The branches for which a particular commit has been made.

    # Exit status:
    #   0 - Success.
    #   1 - Failure.

    # Dependencies:
    #   - None.

    # -------------------------------------------------------------------------

    # Check if the commit is valid.
    if ! git rev-parse --verify "$1" > /dev/null 2>&1; then
        echo "Error: Invalid commit."
        return 1
    fi

    # Get the branches for which the commit has been made.
    git branch --contains "$1" | sed 's/^[* ]*//'

    return 0
}