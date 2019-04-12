FROM php:7.1-alpine as psr

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
    
FROM php:7.1-alpine as xdebug

RUN apk --update --progress --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.8/community add \
    bash \
    gcc \
    libc-dev \
    make \
    php7-dev \
    php7-pear \
    curl

RUN pecl install \
        xdebug \
    && echo "extension=xdebug.so" > /etc/php7/conf.d/10-phalcon.ini

FROM phpstan/phpstan:latest

COPY --from=xdebug /usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303
COPY --from=twistersfury/phalcon /usr/local/lib/php/extensions/no-debug-non-zts-20160303/phalcon.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303
COPY --from=psr /usr/local/lib/php/extensions/no-debug-non-zts-20160303//psr.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303

RUN echo "extension=phalcon.so" > /etc/php7/conf.d/10-phalcon.ini \
    && echo "zend_extension=xdebug.so" > /etc/php7/conf.d/10-xdebug.ini \
    && echo "extension=psr.so" > /etc/php7/conf.d/00-psr.ini

ENTRYPOINT ["phpstan"]
CMD ["analyse", "."]