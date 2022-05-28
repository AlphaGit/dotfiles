if command -v open
then
    open "$@"
    exit $?
fi

if command -v xdg-open
then
    xdg-open "$@"
    exit $?
fi

if command -v start
then
    start "$@"
    exit $?
fi
