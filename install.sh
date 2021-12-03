SCRIPT_LOCATION=$(dirname "$0")
SCRIPT_DIR=$(cd $(dirname $SCRIPT_LOCATION); pwd -P)
# Match all files except . and ..: https://unix.stackexchange.com/a/186219
ln -sf $SCRIPT_DIR/{*,.[^.],.??*} $HOME