FROM twistersfury/phalcon

#Configs For Versions
ENV PHALCON_BRANCH master

RUN docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql

#Installing Phalcon

RUN curl -fsSL https://github.com/phalcon/phalcon-devtools/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd phalcon-devtools-$PHALCON_BRANCH \
    && ./phalcon.sh \
    && ln -s $(pwd)/phalcon.php /usr/local/bin/phalcon

CMD ["/usr/local/bin/phalcon"]