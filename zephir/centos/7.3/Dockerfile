FROM centos:7.4.1708

WORKDIR /app

RUN mkdir -p /app

RUN yum install -y \
        epel-release \
        yum-utils \
    && yum install -y \
            http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum-config-manager --enable remi-php73 \
    && rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/r/re2c-0.14.3-2.el7.x86_64.rpm \
    && yum install -y \
        php-devel \
        php-pear \
        php-xml \
        php-json \
        php-curl \
        php-yaml \
        php-mbstring \
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
    && yum clean all \
    && rm -rf /var/cache/yum

RUN php -i | grep ini \
    && git clone git://github.com/phalcon/php-zephir-parser.git \
    && cd php-zephir-parser \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf php-zephir-parser \
    && echo "extension=zephir_parser.so" >> /etc/php.d/00-zephir-parser.ini

RUN pecl install \
        xdebug \
        redis \
    && rm -rf /tmp/pear \
    # && echo "zend_extension=xdebug.so" >> 00-xdebug.ini \
    && echo "extension=redis.so" >> /etc/php.d//etc/php.d/00-redis.ini