#!/usr/bin/env bash

prog="$(basename $0 .sh)"

update_url="https://dynamicdns.park-your-domain.com/update"
domains="$HOME/.config/namecheap/domains"

usage (){
    echo "usage:

$prog <domain-config>
$prog <host> <domain> <password> [ip]

domains=$domains
"
    exit 1
}

_update-dns (){
    dns_update_url="${update_url}?by=nc&host=${1}&domain=${2}&password=${3}&ip=${4}"
    curl "$dns_update_url"
}

if [ $# -eq 0 ]; then

    for d in  "$domains"/*; do
        source "$domains/$1.conf"
        _update-dns $host $domain $password $ip
    done

elif [ $# -eq 1 ]; then

    [ ! -e "$domains/$1.conf" ] && echo "$prog: $domains/$1.conf: no such file or directory" && exit 1
    source "$domains/$1.conf"
    _update-dns $host $domain $password $ip

elif [ $# -eq 4 ] || [ $# -eq 3 ]; then

    _update-dns $1 $2 $3 $4

else

    usage

fi


