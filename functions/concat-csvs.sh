#!/bin/bash
concat-csvs() {
    # Check if help was requested
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: concat-csvs <output_file> <input_file1> <input_file2> ..."
        echo "Concatenates CSV files into a single CSV file."
        echo "It uses the header of the first file and appends the contents of the other files."
        return 0
    fi

    OUTPUT_FILE=$1
    shift
    INPUT_FILES=($@)

    if [ ${#INPUT_FILES[@]} -eq 0 ]; then
        echo "Error: No input files provided."
        return 1
    fi

    echo ""
    echo "Concatenating CSV files..."
    tail -n +2 -q "${INPUT_FILES[@]}" >> $OUTPUT_FILE.tmp

    # Adding headers to final file
    # Note: for some weird reason, the first file is present in the array at index 1
    # Even if this does not hold, the second file will also have a valid header we can use.
    head -n 1 "${INPUT_FILES[1]}" > $OUTPUT_FILE

    # Adding contents to final file
    cat $OUTPUT_FILE.tmp >> $OUTPUT_FILE

    # Cleaning up
    rm $OUTPUT_FILE.tmp

    echo "Output file: $OUTPUT_FILE"
    echo ""
}