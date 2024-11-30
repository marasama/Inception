#!/bin/bash

if [ ! -d /etc/ssl/private ]; then
    mkdir -p /etc/ssl/private
fi

if [ ! -d /etc/ssl/certs ]; then
    mkdir -p /etc/ssl/certs
fi

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    echo "Nginx: Setting up a new SSL config..."

    if [ -z "$ADDRESS" ]; then
        echo "Error: ADDRESS variable is not set. Aborting."
        exit 1
    fi

    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt \
        -subj "$ADDRESS"

    echo "Nginx: New SSL configuration has been set up."
fi

exec "$@"

