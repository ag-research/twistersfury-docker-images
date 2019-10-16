FROM twistersfury/phalcon

#Configs For Versions
ENV PHALCON_BRANCH 4.0.x

RUN docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql

#Installing Phalcon

RUN curl -fsSL https://github.com/phalcon/phalcon-devtools/archive/$PHALCON_BRANCH.tar.gz | tar xz \
    && cd phalcon-devtools-$PHALCON_BRANCH \
    && chmod +x phalcon.php \
    && ln -s $(pwd)/phalcon.php /usr/local/bin/phalcon

CMD ["/usr/local/bin/phalcon"]
