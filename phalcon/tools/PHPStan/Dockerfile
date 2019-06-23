FROM php:7.3-alpine as psr

#Configs For Versions
ENV PHALCON_BRANCH master
ENV PSR_BRANCH master

RUN apk --update --progress --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.8/community add \
    bash \
    gcc \
    libc-dev \
    make \
    php7-dev \
    php7-pear \
    curl
    
#Installing PSR
RUN curl -fsSL https://github.com/jbboehr/php-psr/archive/$PSR_BRANCH.tar.gz | tar xz \
    && cd php-psr-$PSR_BRANCH \
    && phpize \
    && ./configure \
    && make \
    && make test \
    && make install \
    && docker-php-ext-enable --ini-name 0-psr.ini psr
    
FROM php:7.3-alpine as xdebug

RUN apk --update --progress --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.8/community add \
    bash \
    gcc \
    libc-dev \
    make \
    php7-dev \
    php7-pear \
    curl

RUN pecl install \
        xdebug

FROM php:7.3-alpine

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ARG PHPSTAN_VERSION

RUN mkdir -p /etc/php7/conf.d \
    && echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/10-phalcon.ini \
    && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/10-xdebug.ini \
    && echo "extension=psr.so" > /usr/local/etc/php/conf.d/00-psr.ini \
    && echo "memory_limit=-1" > /usr/local/etc/php/conf.d/99_memory-limit.ini

COPY --from=xdebug /usr/local/lib/php/extensions/no-debug-non-zts-20180731/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/
COPY --from=registry.gitlab.com/twistersfury/docker-images/phalcon:master /usr/local/lib/php/extensions/no-debug-non-zts-20180731/phalcon.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/
COPY --from=psr /usr/local/lib/php/extensions/no-debug-non-zts-20180731/psr.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN rm -rf /var/cache/apk/* /var/tmp/* /tmp/* \
    && composer global require phpstan/phpstan-shim "$PHPSTAN_VERSION"

ENTRYPOINT ["phpstan"]
CMD ["analyse", "."]
