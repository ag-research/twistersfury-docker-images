FROM docker:latest

RUN apk --no-cache add py-pip libffi-dev openssl-dev gcc libc-dev make git openssh openssl wget bash curl

ARG COMPOSE_VERSION
ENV COMPOSE_VERSION ${COMPOSE_VERSION:-master}

RUN pip install git+git://github.com/docker/compose@$COMPOSE_VERSION