FROM phpstan/phpstan:latest

#Configs For Versions
ENV PHALCON_BRANCH master

#Installing Phalcon
RUN ln -s /usr/bin/sh /usr/bin/bash
RUN curl -fsSL https://github.com/phalcon/cphalcon/archive/$PHALCON_BRANCH.tar.gz | tar xz
RUN cd cphalcon-$PHALCON_BRANCH
RUN cd build
RUN ./install
RUN cd ../../
RUN docker-php-ext-enable phalcon
RUN rm -rf cphalcon-$PHALCON_BRANCH