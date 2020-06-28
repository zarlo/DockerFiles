FROM python:3.7.7

VOLUME /etc/letsencrypt/

RUN pip install certbot certbot-dns-powerdns \
 certbot-dns-cloudflare certbot-dns-cloudxns \
 certbot-dns-digitalocean certbot-dns-dnsimple \
 certbot-dns-dnsmadeeasy certbot-dns-google \
 certbot-dns-linode certbot-dns-luadns \
 certbot-dns-nsone certbot-dns-ovh \
 certbot-dns-rfc2136 certbot-dns-route53 \
 certbot-pdns

