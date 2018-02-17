FROM alpine

COPY ./entrypoint.sh /mnt/entrypoint.sh

RUN chmod +x /mnt/entrypoint.sh

ENTRYPOINT ["/mnt/entrypoint.sh"]
CMD ["/usr/sbin/crond", "-f", "-d", "0"]
