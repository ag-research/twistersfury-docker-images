FROM php:7.1-fpm

#Configs For Versions
ENV PHALCON_BRANCH master
ENV PARSER_BRANCH master
ENV COMPOSER_DIR /usr/local/bin

RUN apt-get update && apt-get install -y \
        automake \
        git \
    && rm -rf /var/lib/apt/lists/*

# Uninstall The Existing re2c Package - We Don't Need It
RUN apt-get remove -y re2c \
    && rm -rf /var/lib/apt/lists/*

# Installing Newest Version of re2c
RUN curl -fsSL https://github.com/skvadrik/re2c/archive/master.tar.gz | tar zx \
    && cd re2c-master/re2c \
    && autoreconf -i -W all \
    && ./configure \
    && make \
    && make install \
    && make bootstrap \
    && make clean \
    && cd ../../ \
    && rm -rf re2c-master

# Install Phalcon Zephir Parser
RUN curl -fsSL https://github.com/phalcon/php-zephir-parser/archive/$PARSER_BRANCH.tar.gz | tar xz \
    && cd php-zephir-parser-master \
    && ./install \
    && cd ../ \
    && rm -rf php-zephir-parser-master \
    && docker-php-ext-enable zephir_parser

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=$COMPOSER_DIR --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install Phalcon
RUN curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd cphalcon-master \
    && composer install \
    && composer clear-cache \
    && ./vendor/bin/zephir build --buildEngine=ZendEngine3 \
    && cd build \
    && ./install \
    && cd ../../ \
    && rm -rf cphalcon-master \
    && docker-php-ext-enable phalcon

# Post Install Clean Up
RUN rm -rf $COMPOSER_DIR/composer \
    && apt-get remove -y \
        automake \
        git \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*