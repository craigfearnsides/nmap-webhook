# nmap-webhook
This is a small Dancer2 web server to act as a front for NMAP::Parser

## Simply...
* docker build --tag nmap-webhook .
* docker run -p8080:3000 -d nmap-webhook

## Further advice
I'd recommend putting an [nginx] or [caddy] reverse proxy in front of this container.

[nginx]: https://github.com/stephenafamo/docker-nginx-auto-proxy
[caddy]: https://caddyserver.com
