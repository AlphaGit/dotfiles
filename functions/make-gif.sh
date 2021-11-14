make-gif() {
    # based on https://cassidy.codes/blog/2017/04/25/ffmpeg-frames-to-gif-optimization/

    # verify that the first parameter is a valid input set of files
    if [ -z "$1" ]; then
        echo "No input files specified"
        return 1
    fi

    # verify that the second parameter is a valid output file
    if [ -z "$2" ]; then
        echo "No output file specified"
        return 1
    fi

    palette="/tmp/palette.png"
    # 24 fps, default for blender
    filters="fps=24,scale=720:-1:flags=lanczos"
    ffmpeg -v warning -i $1 -vf "$filters,palettegen=stats_mode=diff" -y $palette
    ffmpeg -i $1 -i $palette -lavfi "$filters,paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y $2
}