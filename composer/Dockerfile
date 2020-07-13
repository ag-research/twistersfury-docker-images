FROM twistersfury/phalcon

USER root
RUN mkdir -p /app
WORKDIR /app

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        ssh \
        zip \
        unzip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installing Async Plugin
RUN composer global require --prefer-dist --no-interaction --optimize-autoloader --apcu-autoloader \
        "hirak/prestissimo"

#CMD ["/usr/bin/composer"]