FROM alpine:latest

RUN apk add --no-cache curl

# Default environment variables
ENV HOSTNAME=none \
    LOGIN=none \
    PASSWORD=none \
    LOG_TYPE=STDOUT

# Script location
COPY updater.sh /home/updater.sh

RUN chmod +x /home/updater.sh

# Infinite loop: run script every 5 minutes
CMD ["sh", "-c", "while true; do /home/updater.sh; sleep 300; done"]
