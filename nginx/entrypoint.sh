#!/bin/sh

ENV_VARS='$ENV_DOMAIN_NAME:$ENV_UPSTREAM_HOST';

if [ -z "/mnt/letsencrypt/live/$ENV_DOMAIN_NAME" ]; then
    mkdir -p "/etc/letsencrypt/live/${ENV_DOMAIN_NAME}";

    mv /mnt/certificate.crt /etc/letsencrypt/live/${ENV_DOMAIN_NAME}/fullchain.pem;
    mv /mnt/privateKey.key /etc/letsencrypt/live/${ENV_DOMAIN_NAME}/privkey.pem;
    mv /mnt/certificate.crt /etc/letsencrypt/live/${ENV_DOMAIN_NAME}/chain.pem;
fi

envsubst "$ENV_VARS" \
    < /mnt/letsencrypt.template \
    > /etc/nginx/conf.d/letsencrypt.conf

envsubst "$ENV_VARS" \
    < /mnt/upstream.template \
    > /etc/nginx/conf.d/upstream.conf

nginx -t

echo "$@"

exec "$@"