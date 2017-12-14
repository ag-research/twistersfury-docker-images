FROM twistersfury/phalcon:latest

FROM twistersfury/php:fpm-7.1-debug

COPY --from=0 /usr/local/lib/php/extensions/no-debug-non-zts-20160303/phalcon.so /usr/local/lib/php/extensions/debug-non-zts-20160303

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --enable-debug

RUN apt-get update && apt-get -y install \
        gdb-minimal \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install \
        xdebug \
    && docker-php-ext-enable \
        phalcon \
        xdebug \
    && rm -rf /tmp/pear