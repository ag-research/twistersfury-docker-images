FROM php:7.1-alpine as psr

#Configs For Versions
ENV PHALCON_BRANCH master
ENV PSR_BRANCH master

RUN apk --update --progress --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.8/community add \
    bash \
    gcc \
    libc-dev \
    make \
    curl
    
#Installing PSR
RUN curl -fsSL https://github.com/jbboehr/php-psr/archive/$PSR_BRANCH.tar.gz | tar xz \
    && cd php-psr-$PSR_BRANCH \
    && phpize \
    && ./configure \
    && make \
    && make test \
    && make install

FROM phpstan/phpstan:latest

RUN apk --update --progress --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.8/community add \
    bash \
    gcc \
    libc-dev \
    make \
    php7-dev \
    php7-pear \
    curl

#Installing Phalcon
RUN curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd cphalcon-$PHALCON_BRANCH \
    && cd build \
    && ./install \
    && cd ../../ \
    && php -i | grep ini \
    && echo "extension=phalcon.so" > /etc/php7/conf.d/10-phalcon.ini \
    && rm -rf cphalcon-$PHALCON_BRANCH

COPY --from=psr /usr/lib/php7/modules/psr.so /usr/lib/php7/modules

RUN pecl install \
        xdebug \
    && rm -rf /tmp/pear

ENTRYPOINT ["phpstan"]
CMD ["analyse", "."]