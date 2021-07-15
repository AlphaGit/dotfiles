alias python=python3

alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'

alias mostrecent='find $1 -type f -print0 | xargs -0 stat --format "%Y:%n" | sort -nr | cut -d: -f2- | head -n 1'

# clipboard
alias c='xclip -selection clipboard'
alias v='xclip -o'

# kubernetes
alias kdev='kubectl -n dev'
alias kprod='kubectl -n prod'
alias ktest='kubectl -n test'
alias kcommon='kubectl -n common'

# https://unix.stackexchange.com/a/25329/305924
alias watch='watch '
