#!/bin/sh

ENV_VARS='$ENV_DOMAIN_NAME:$ENV_UPSTREAM_HOST';

envsubst "$ENV_VARS" \
    < /mnt/letsencrypt.template \
    > /etc/nginx/conf.d/letsencrypt.conf

envsubst "$ENV_VARS" \
    < /mnt/upstream.template \
    > /etc/nginx/conf.d/upstream.conf

nginx -t

echo "$@"

exec "$@"