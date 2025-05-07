#!/bin/bash
set -e
set -x

# Retry APT install up to 2 times
for i in 1 2; do
    # Clear APT cache and update
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
    sudo apt-get update --fix-missing

    # Fix broken dependencies
    sudo apt --fix-broken install -y
    sudo apt-get install -y --fix-missing \
        libldap2-dev libsasl2-dev postgresql postgresql-client libpq-dev && break
    echo "APT install failed, retrying ($i/3)..."
    sleep 2
done