FROM twistersfury/phalcon

WORKDIR /app

RUN mkdir -p /app

ENV ZEPHIR_PARSER master

RUN apt-get update && apt-get install -y \
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
    && rm -rf /var/lib/apt/lists/*

RUN pecl install \
        xdebug \
        redis \
    && rm -rf /tmp/pear \
    # && echo "zend_extension=xdebug.so" >> 00-xdebug.ini \
    && docker-php-ext-enable redis

#Installing PSR
RUN curl -fsSL https://github.com/phalcon/php-zephir-parser/archive/$ZEPHIR_PARSER.tar.gz | tar xz \
    && cd php-zephir-parser-$ZEPHIR_PARSER \
    && phpize \
    && ./configure \
    && make \
    && make test \
    && make install \
    && cd ../ \
    && docker-php-ext-enable zephir_parser \
    && rm -rf php-zephir-parser-$ZEPHIR_PARSER

