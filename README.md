# namecheap-dns

## Description

Script to update [namecheap.com](https://namecheap.com) domains based on their own Windows only utility.

## Usage

`update-dns \* domain password ip`

`update-dns www example password`

`update-dns domain`

It can be easily integrated with any crontab or external scripts.

Successfully updating a domain via the 3 or 4 argument script invocation will add its profile to the default domains location.

## Domains

Domain config files are by default located in `$HOME/.config/namecheap/domains/`.

example.com.conf 

```
host=*
domain=example.com
password=changeme
ip=
```





