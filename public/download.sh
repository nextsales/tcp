mkdir -p "$(dirname "$1")"
wget -P "$(dirname "$1")" -N "http://demo.okendoken.com/$1"