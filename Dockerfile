FROM alpine:latest

RUN apk add --no-cache curl

# Default environment variables
ENV HOSTNAME=none \
    LOGIN=none \
    PASSWORD=none \
    LOG_TYPE=STDOUT \
    REFRESH_TIME=5

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

