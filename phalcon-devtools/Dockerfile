FROM twistersfury/phalcon

#Configs For Versions
ENV PSR_BRANCH master
ENV ZEPHIR_PARSER master
ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ARG ZEPHIR_VERSION
ENV PHALCON_BRANCH 4.0.x

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
        curl \
        git \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql

#Installing Phalcon

RUN curl -fsSL https://github.com/phalcon/phalcon-devtools/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd phalcon-devtools-$PHALCON_BRANCH \
    && composer install --no-suggest --ignore-platform-reqs --no-interaction --no-scripts --prefer-dist \
    && ln -s $(pwd)/phalcon /usr/local/bin/phalcon

CMD ["/usr/local/bin/phalcon"]
