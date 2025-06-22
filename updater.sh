#!/bin/sh

set -e

# Initial ENV vars check
if [ -z "$HOSTNAME" ] || [ "$HOSTNAME" = "none" ]; then
    echo "Error: HOSTNAME is not set or empty."
    exit 1
fi
if [ -z "$LOGIN" ] || [ "$LOGIN" = "none" ]; then
    echo "Error: LOGIN is not set or empty."
    exit 1
fi
if [ -z "$PASSWORD" ] || [ "$PASSWORD" = "none" ]; then
    echo "Error: PASSWORD is not set or empty."
    exit 1
fi
if [ "$LOG_TYPE" != "file" ] && [ "$LOG_TYPE" != "STDOUT" ]; then
    echo "Error: LOG_TYPE must be either 'file' or 'STDOUT'."
    exit 1
fi

# Utilities definition
CURRENT_DATETIME=$(date -R)
IP=$(curl -s ifconfig.co)

if [ "$LOG_TYPE" = "file" ]; then
    mkdir -p "/var/log/scripts"
    PATH_LOG="/var/log/scripts/ovh_dynhost_updater.log"
    touch "$PATH_LOG" #create `.log` if not present yet
fi

# Actual update
OUTPUT=$(curl -s --location-trusted --user "$LOGIN:$PASSWORD" "https://www.ovh.com/nic/update?system=dyndns&hostname=$HOSTNAME&myip=$IP")
if [ "$LOG_TYPE" = "file" ]; then
    printf "[%s] - Server replied: %s\n" "$CURRENT_DATETIME" "$OUTPUT" | tee -a "$PATH_LOG"
else
    printf "[%s] - Server replied: %s\n" "$CURRENT_DATETIME" "$OUTPUT"
fi

printf "\n\n\n"
exit 0
