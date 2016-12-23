# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "cannot run as shell script" 1>&2
    return 1
fi

