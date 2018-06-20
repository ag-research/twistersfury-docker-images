#!/bin/sh

ENV_VARS='$ENV_DOMAIN_NAME:$ENV_UPSTREAM_HOST';

# Allow Ability To Disable HTTPS Files (Only Load HTTP)
if [ -z "$ENV_IGNORE_HTTPS" ]; then
    envsubst "$ENV_VARS" \
        < /mnt/letsencrypt-http.template \
        > /etc/nginx/conf.d/letsencrypt-http.conf

    envsubst "$ENV_VARS" \
        < /mnt/letsencrypt-https.template \
        > /etc/nginx/conf.d/letsencrypt-https.conf
fi

envsubst "$ENV_VARS" \
    < /mnt/upstream.template \
    > /etc/nginx/conf.d/upstream.conf

nginx -t

echo "$@"

exec "$@"