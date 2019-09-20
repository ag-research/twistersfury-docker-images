FROM nginx:1.13

EXPOSE 80 443
ENTRYPOINT ["/mnt/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

RUN mkdir -p /data/letsencrypt && \
    mkdir -p /etc/letsencrypt/live/

RUN echo "OKAY" > /data/letsencrypt/ci.log

COPY ./entrypoint.sh /mnt/entrypoint.sh
COPY ./letsencrypt-http.conf /mnt/letsencrypt-http.template
COPY ./letsencrypt-https.conf /mnt/letsencrypt-https.template
COPY ./letsencrypt-https.conf /mnt/letsencrypt-renew.template
COPY ./upstream.conf /mnt/upstream.template

RUN chmod +x /mnt/entrypoint.sh