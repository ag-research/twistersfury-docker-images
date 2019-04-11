FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

#Configs For Versions
ENV PHALCON_BRANCH master
ENV PSR_BRANCH master

#Installing Phalcon
RUN curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd cphalcon-$PHALCON_BRANCH \
    && cd build \
    && ./install \
    && cd ../../ \
    && docker-php-ext-enable phalcon \
    && rm -rf cphalcon-$PHALCON_BRANCH
    
#Installing Phalcon
RUN curl -fsSL https://github.com/jbboehr/php-psr/archive/$PSR_BRANCH.tar.gz | tar xz \
    && cd php-psr-$PSR_BRANCH \
    && phpize \
    && ./configure \
    && make \
    && make test \
    && cd ../ \
    && docker-php-ext-enable psr \
    && rm -rf php-psr-$PSR_BRANCH