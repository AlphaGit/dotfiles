kubeconfig-switch() {
    RED=`tput setaf 1`
    GREEN=`tput setaf 2`
    NC=`tput sgr0`

    FILE=~/.kube/$1.config.yaml
    if [ -f "$FILE" ]; then
        export KUBECONFIG=~/.kube/$1.config.yaml
        echo -e "${GREEN}Success:${NC} Using Kube $1 configuration."
    else
        echo -e "${RED}Error:${NC} Config file $FILE not found!"
    fi
}