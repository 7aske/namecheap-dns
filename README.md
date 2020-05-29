# namecheap-dns

## Description

Script to update [namecheap.com](https://namecheap.com) domains based on their own Windows only utility.

## Usage

`update-dns \* domain password ip`

`update-dns www example password`

`update-dns domain`

It can be easily integrated with any crontab or external scripts.

## Domains

Domain config files are by default located in `$HOME/.config/namecheap/domains/`.

example.com.conf 
```
host=\\*,www,@
domain=example.com
password=changeme
ip=
```





