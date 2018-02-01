FROM docker:latest

RUN apk --no-cache add curl git openssh openssl wget

ARG COMPOSE_VERSION
ENV COMPOSE_VERSION ${COMPOSE_VERSION}

RUN if [ -z "$COMPOSE_VERSION" ]; then COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4); fi \
    && sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/run.sh > /usr/local/bin/docker-compose" \
    && chmod +x /usr/local/bin/docker-compose