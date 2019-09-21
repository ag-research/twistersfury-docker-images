#!/bin/sh

ENV_VARS='$ENV_DOMAIN_NAME:$ENV_UPSTREAM_HOST:$ENV_APPLICATION_ENV';

# Setup For Lets Encrypt
if [ -n "ENV_LETS_ENCRYPT" ]; then
    echo "Running In Lets Encrypt Mode"
    envsubst "$ENV_VARS" \
        < /mnt/letsencrypt-renew.template \
        > /etc/nginx/conf.d/letsencrypt-renew.conf
# Allow Ability To Disable HTTPS Files (Only Load HTTP)
elif [ -z "$ENV_IGNORE_HTTPS" ]; then
    echo "Running In HTTPS Mode"
    envsubst "$ENV_VARS" \
        < /mnt/letsencrypt-https.template \
        > /etc/nginx/conf.d/letsencrypt-https.conf
# HTTP Only
else
    echo "Running In Http Mode"
    envsubst "$ENV_VARS" \
        < /mnt/letsencrypt-http.template \
        > /etc/nginx/conf.d/letsencrypt-http.conf
fi

if [ -z "ENV_LETS_ENCRYPT" ]; then
    envsubst "$ENV_VARS" \
        < /mnt/upstream.template \
        > /etc/nginx/conf.d/upstream.conf
    
    if [ -f /mnt/nginx.template ]; then
        envsubst "$ENV_VARS" \
            < /mnt/nginx.template \
            > /etc/nginx/conf.d/default.conf
    fi
fi

nginx -t

echo "$@"

exec "$@"
