FROM twistersfury/php:fpm-7.1-debug

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --enable-debug

RUN apt-get update && apt-get -y install \
        gdb-minimal \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install \
        xdebug \
    && docker-php-ext-enable \
        xdebug \
    && rm -rf /tmp/pear