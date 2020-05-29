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
    for host in $(echo $1 | sed -e 's/,/\n/g'); do 
        host="$(echo "$host" | sed -e 's/\\\*/\*/')"
        dns_update_url="${update_url}?by=nc&host=${host}&domain=${2}&password=${3}&ip=${4}"
        resp="$(curl -s "$dns_update_url" 2>/dev/null)"
        err_count="$(echo "$resp" | sed -e 's/.*<ErrCount>\([0-9]\)<\/ErrCount>.*/\1/')"
        ip_addr="$(echo "$resp" | sed -e 's/.*<IP>\([0-9.]*\)<\/IP>.*/\1/')"
        if [ "$err_count" = "0" ]; then
            echo "$host.$domain -> $ip_addr"
        else
            echo "$prog: failed syncing $host.$domain"
        fi
    done    
}

_save-conf (){
    echo -e "host=$1\ndomain=$2\npassword=$3\nip=$4\n" > "$domains/$2.conf"
}

if [ $# -eq 0 ]; then

    for d in  "$domains"/*; do
        source "$d"
        _update-dns $host $domain $password $ip
    done

elif [ $# -eq 1 ]; then

    [ ! -e "$domains/$1.conf" ] && echo "$prog: $domains/$1.conf: no such file or directory" && exit 1
    source "$domains/$1.conf"
    _update-dns $host $domain $password $ip

elif [ $# -eq 4 ] || [ $# -eq 3 ]; then

    _update-dns $1 $2 $3 $4 && \
    _save-conf  $1 $2 $3 $4

else

    usage

fi


