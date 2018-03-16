FROM twistersfury/php:fpm-7.1-debug

RUN apt-get update && apt-get -y install \
        gdb-minimal \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install \
        xdebug \
    && docker-php-ext-enable \
        xdebug \
    && rm -rf /tmp/pear

#Configs For Versions
ENV PHALCON_BRANCH master

#Installing Phalcon
RUN curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd cphalcon-$PHALCON_BRANCH \
    && cd build \
    && ./install \
    && cd ../../ \
    && docker-php-ext-enable phalcon \
    && rm -rf cphalcon-$PHALCON_BRANCH
