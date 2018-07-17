#!/bin/sh

ENV_VARS='$ENV_DOMAIN_NAME:$ENV_UPSTREAM_HOST:$ENV_APPLICATION_ENV';

# Updating Lets Encrypt
if [ ! -z "ENV_LETS_ENCRYPT" ]; then
    envsubst "$ENV_VARS" \
        < /mnt/letsencrypt-http.template \
        > /etc/nginx/conf.d/letsencrypt-http.conf
fi

# Allow Ability To Disable HTTPS Files (Only Load HTTP)
if [ -z "$ENV_IGNORE_HTTPS" ]; then
    envsubst "$ENV_VARS" \
        < /mnt/letsencrypt-https.template \
        > /etc/nginx/conf.d/letsencrypt-https.conf
fi

envsubst "$ENV_VARS" \
    < /mnt/upstream.template \
    > /etc/nginx/conf.d/upstream.conf

if [ -f /mnt/nginx.template ]; then
    envsubst "$ENV_VARS" \
        < /mnt/nginx.template \
        > /etc/nginx/conf.d/default.conf
fi

nginx -t

echo "$@"

exec "$@"