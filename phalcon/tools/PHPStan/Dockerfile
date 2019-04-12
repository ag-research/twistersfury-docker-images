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

COPY --from=xdebug /tmp/pear/temp/pear-build-defaultuserOnIHfA/xdebug-2.7.1/modules/xdebug.so /usr/lib/modules
COPY --from=xdebug /etc/php7/conf.d/10-xdebug.ini /etc/php7/conf.d/

COPY --from=twistersfury/phalcon /usr/lib/php7/modules/phalcon.so /usr/lib/modules
COPY --from=twistersfury/phalcon /etc/php7/conf.d/xdebug.ini /etc/php7/conf.d

COPY --from=psr /usr/lib/php7/modules/psr.so /usr/lib/php7/modules
COPY --from=psr /etc/php7/conf.d/xdebug.ini /etc/php7/conf.d

ENTRYPOINT ["phpstan"]
CMD ["analyse", "."]