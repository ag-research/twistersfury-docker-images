FROM phpstan/phpstan:latest

#Configs For Versions
ENV PHALCON_BRANCH master

#Installing Phalcon
RUN ln -s /usr/bin/sh /usr/bin/bash \
    && curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    &&  cd cphalcon-$PHALCON_BRANCH/build

RUN ./cphalcon-$PHALCON_BRANCH/build/install
RUN cd ../../
RUN docker-php-ext-enable phalcon
RUN rm -rf cphalcon-$PHALCON_BRANCH