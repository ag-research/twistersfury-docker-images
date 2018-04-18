FROM phpstan/phpstan:latest

#Configs For Versions
ENV PHALCON_BRANCH master

RUN apk --update --progress --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/community add \
    bash \
    gcc \
    libc-dev \
    make \
    php7-dev

#Installing Phalcon
RUN curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd cphalcon-$PHALCON_BRANCH \
    && cd build \
    && ./install \
    && cd ../../ \
    && echo "extension=phalcon.so" > /usr/local/etc/php.d/10-phalcon.ini
    && rm -rf cphalcon-$PHALCON_BRANCH