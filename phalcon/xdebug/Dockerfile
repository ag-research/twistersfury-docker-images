FROM twistersfury/phalcon

RUN pecl install \
        yaml \
        xdebug \
    && docker-php-ext-enable \
        yaml \
        xdebug \
    && rm -rf /tmp/pear