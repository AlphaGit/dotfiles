# Inspired in https://tommckenzie.dev/posts/reduce-shell-startup-time-by-lazy-loading-nvm.html
function lazy_nvm {
  unset -f nvm
  unset -f npm
  unset -f node
  unset -f npx
  unset -f yarn

  if [ -d "${HOME}/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # linux
    [ -s "$(brew --prefix nvm)/nvm.sh" ] && source $(brew --prefix nvm)/nvm.sh # osx
  fi
}

# aliases
function nvm { lazy_nvm; nvm "$@"; }
function npm { lazy_nvm; npm "$@"; }
function node { lazy_nvm; node "$@"; }
function npx { lazy_nvm; npx "$@"; }
function yarn { lazy_nvm; yarn "$@"; }
