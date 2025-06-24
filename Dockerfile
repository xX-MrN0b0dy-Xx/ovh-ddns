FROM alpine:latest

LABEL org.opencontainers.image.authors="github@xX-MrN0b0dy-Xx" \
      org.opencontainers.image.source="https://github.com/xX-MrN0b0dy-Xx/ovh-ddns" \
      org.opencontainers.image.title="ovh-ddns" \
      org.opencontainers.image.description="A simple but effective containerized implementation of my script to update the Dynamic Public IP utilizing the OVH DDNS Service DynHost"

RUN apk add --no-cache curl

# Default environment variables
ENV HOSTNAME="" \
    LOGIN="" \
    PASSWORD="" \
    LOG_TYPE=STDOUT \
    REFRESH_TIME=5

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

