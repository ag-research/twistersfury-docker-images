FROM php:7.3-fpm

WORKDIR /app

ARG PHALCON_BRANCH=master

#Configs For Versions
ENV PHALCON_BRANCH $PHALCON_BRANCH
ENV PSR_BRANCH master
ENV ZEPHIR_PARSER master
ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ARG ZEPHIR_VERSION

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN mkdir -p /app

RUN apt-get update && apt-get install -y \
        curl \
        build-essential \
        libpcre3-dev \
        gcc \
        make \
        re2c \
        autoconf \
        automake \
        git \
        sudo \
        file \
        libmemcached-dev \
        zlib1g-dev \
        libmagickwand-dev \
        libyaml-dev \
        gdb \
        lcov \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN pecl install \
        xdebug \
        redis \
        memcached \
        igbinary \
        msgpack \
        apcu \
        imagick \
        yaml \
        pcov \
    && rm -rf /tmp/pear \
    # && echo "zend_extension=xdebug.so" >> 00-xdebug.ini \
    && docker-php-ext-enable \
        redis \
        memcached \
        igbinary \
        msgpack \
        apcu \
        imagick \
        yaml \
        pcov \
    && docker-php-ext-install \
        gd \
        gettext

#Installing Zephir Parser
RUN curl -fsSL https://github.com/phalcon/php-zephir-parser/archive/$ZEPHIR_PARSER.tar.gz | tar xz \
    && cd php-zephir-parser-$ZEPHIR_PARSER \
    && phpize \
    && ./configure \
    && make \
    && make test \
    && make install \
    && cd ../ \
    && docker-php-ext-enable zephir_parser \
    && rm -rf php-zephir-parser-$ZEPHIR_PARSER \
    && composer global require phalcon/zephir "$ZEPHIR_VERSION"

#Installing PSR
RUN curl -fsSL https://github.com/jbboehr/php-psr/archive/$PSR_BRANCH.tar.gz | tar xz \
    && cd php-psr-$PSR_BRANCH \
    && phpize \
    && ./configure \
    && make \
    && make test \
    && make install \
    && cd ../ \
    && docker-php-ext-enable --ini-name 0-psr.ini psr \
    && rm -rf php-psr-$PSR_BRANCH

#Installing Phalcon
RUN curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd cphalcon-$PHALCON_BRANCH \
    && composer install --no-suggest --ignore-platform-reqs --no-interaction --no-scripts --prefer-source \
    && php -d memory_limit=-1 /composer/vendor/bin/zephir build --export-classes \
    && docker-php-ext-enable phalcon \
    && cd ../ \
    && mv cphalcon-$PHALCON_BRANCH /opt/cphalcon #Moving For Building

RUN echo "apc.enable_cli=1" > /usr/local/etc/php/conf.d/00-apc.ini \
    && echo "apc.enable=1" >> /usr/local/etc/php/conf.d/00-apc.ini