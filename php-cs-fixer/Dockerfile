FROM php:7.3-fpm

WORKDIR /app

#Configs For Versions
ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
            git \
        && rm -rf /var/lib/apt/lists/*

RUN composer global require friendsofphp/php-cs-fixer

