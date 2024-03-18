# Add symlinks to all files in this directory to the home directory
SCRIPT_LOCATION=$(dirname "$0")
SCRIPT_DIR=$(cd $(dirname $SCRIPT_LOCATION); pwd -P)
find $SCRIPT_DIR -maxdepth 1 ! -path "$SCRIPT_DIR/.git" ! -name "install.sh" ! -path "$SCRIPT_DIR/local_bin" -exec sh -c 'ln -sfn "$0" $HOME && echo "Linking $0 → $HOME/$(basename "$0")"' {} \;
find $SCRIPT_DIR/local_bin -maxdepth 1 ! -exec sh -c 'ln -sfn "$0" /usr/local/bin && echo "Linking $0 → /usr/local/bin/$(basename "$0")"' {} \;

# Install cron jobs
crontab -l | cat - $SCRIPT_DIR/.alpha_crontab | sort -r | uniq | crontab -