FROM twistersfury/phalcon

RUN apt-get update && apt-get -y install \
        gdb-minimal \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install \
        xdebug \
    && docker-php-ext-enable \
        xdebug \
    && rm -rf /tmp/pear