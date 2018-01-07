FROM nginx:1.13

EXPOSE 80 443
ENTRYPOINT ["/mnt/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

RUN mkdir -p /data/letsencrypt && \
    mkdir -p /etc/letsencrypt/live/

RUN echo "OKAY" > /data/letsencrypt/ci.log

COPY ./entrypoint.sh /mnt/entrypoint.sh
COPY ./letsencrypt.conf /mnt/letsencrypt.template
COPY ./upstream.conf /mnt/upstream.template
COPY ./certificate.crt /mnt/certificate.crt
COPY ./privateKey.key /mnt/privateKey.key

RUN chmod +x /mnt/entrypoint.sh