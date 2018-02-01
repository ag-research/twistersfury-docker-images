FROM docker:latest

RUN apk --no-cache add py-pip git openssh openssl wget

ARG COMPOSE_VERSION
ENV COMPOSE_VERSION ${COMPOSE_VERSION:-master}

RUN pip install git+git://github.com/docker/compose@$COMPOSE_VERSION