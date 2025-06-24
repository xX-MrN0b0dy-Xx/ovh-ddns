#!/bin/sh

set -e

# Initial ENV vars check
if [ -z "$HOSTNAME" ] || [ "$HOSTNAME" = "none" ]; then
    echo "[Error] HOSTNAME is not set or empty."
    exit 1
fi
if [ -z "$LOGIN" ] || [ "$LOGIN" = "none" ]; then
    echo "[Error] LOGIN is not set or empty."
    exit 1
fi
if [ -z "$PASSWORD" ] || [ "$PASSWORD" = "none" ]; then
    echo "[Error] PASSWORD is not set or empty."
    exit 1
fi
if [ "$LOG_TYPE" != "file" ] && [ "$LOG_TYPE" != "STDOUT" ]; then
    echo "[Error] LOG_TYPE must be either 'file' or 'STDOUT'."
    exit 1
fi

if [ -z "$REFRESH_TIME" ] || ! echo "$REFRESH_TIME" | grep -Eq '^[0-9]+$'; then
    echo "[Error] REFRESH_TIME must be set and a positive integer (in minutes)."
    exit 1
fi

printf "[INFO] [%s] - Initialization\n" "$(date -R)"

# Log initialization
if [ "$LOG_TYPE" = "file" ]; then
    mkdir -p "/var/log/scripts"
    PATH_LOG="/var/log/scripts/ovh_dynhost_updater.log"
    touch "$PATH_LOG" #create `.log` if not present yet
fi

# Utilities outside loop definition
SLEEP_TIME=`expr "$REFRESH_TIME" \* 60`

while true; do
    # Utilities inside loop definition
    CURRENT_DATETIME=$(date -R)
    IP=$(curl -s ifconfig.co)

    # Actual update
    OUTPUT=$(curl -s --location-trusted --user "$LOGIN:$PASSWORD" "https://www.ovh.com/nic/update?system=dyndns&hostname=$HOSTNAME&myip=$IP")
    if [ "$LOG_TYPE" = "file" ]; then
        printf "[%s] - Server replied: %s\n" "$CURRENT_DATETIME" "$OUTPUT" >> "$PATH_LOG"
    fi
    printf "[INFO] [%s] - Server replied: %s\n" "$CURRENT_DATETIME" "$OUTPUT"
    printf "[INFO] [%s] - Sleeping for %s minutes...\n" "$REFRESH_TIME"
    sleep "$SLEEP_TIME"
done
exit 0
