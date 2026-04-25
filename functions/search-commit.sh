search-commit() {
    # Returns the list of branches that a commit is part of

    # Arguments:
    #   $1: commit message

    # Returns:
    #   0: success
    #   1: failure

    # Example:
    #   search-commit "Merge pull request #1 from origin/master"

    # Check if the commit message is empty
    local commit_message="$1"
    if [ -z "$1" ]; then
        return 1
    fi

    # Get the list of commit hashes
    commits=("${(@f)$(git log --all --grep $commit_message --format='%H %s')}")

    # Check if the list is empty
    if [ -z "$commits" ]; then
        return 1
    fi

    for commit in $commits; do
        # Split the hash and the commit message
        hash="$(echo $commit | cut -d' ' -f1)"
        message="$(echo $commit | cut -d' ' -f2-)"

        tags=("${(@f)$(git tag --contains $hash)}")
        branches=("${(@f)$(git branch -a --contains $hash)}")

        echo "Hash: $hash"
        echo "Message: $message"
        for tag in $tags; do
            echo "Tag: $tag"
        done
        for branch in $branches; do
            echo "Branch: $branch"
        done
    done

    return 0
}