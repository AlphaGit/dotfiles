concat-videos() {
    # Check if help was requested
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: concat-videos <output_file> <input_file1> <input_file2> ..."
        echo "Concatenates videos into a single video file."
        echo "The input files will be converted to a common resolution (1920x1080) before concatenation."
        return 0
    fi

    OUTPUT_FILE=$1
    shift
    INPUT_FILES=($@)

    echo ""
    echo "Concatenating videos: "
    for input_file in $INPUT_FILES; do
        echo "- $input_file"
    done
    echo "Output file: $OUTPUT_FILE"
    echo ""

    for file in $INPUT_FILES; do
        echo -n "Converting $file to common format... "
        ffmpeg -hide_banner -loglevel error -i $file -s 1920x1080 $file.common.mp4
        echo "Done."
    done

    echo -n "Concatenating videos... "
    BASE_OUTPUT_FILE="${OUTPUT_FILE%.*}"
    TMP_LIST="$BASE_OUTPUT_FILE.list.tmp"
    cat /dev/null > $TMP_LIST
    for file in $INPUT_FILES; do
        echo "file '$file.common.mp4'" >> $TMP_LIST
    done
    ffmpeg -hide_banner -loglevel error -f concat -safe 0 -i $TMP_LIST -c copy $BASE_OUTPUT_FILE.intermediate.mp4
    echo "Done."

    echo -n "Converting to final format... "
    ffmpeg -hide_banner -loglevel error -i $BASE_OUTPUT_FILE.intermediate.mp4 -vcodec libx265 -crf 28 $OUTPUT_FILE
    echo "Done."

    #echo -n "Cleaning up..."
    rm $TMP_LIST $BASE_OUTPUT_FILE.intermediate.mp4
    for file in $INPUT_FILES; do
       rm $file.common.mp4
    done
    #echo "Done."
}