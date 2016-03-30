#!/bin/bash

mkdir -p /tmp/output
vault-load.py "$1"
sudo cp -R /tmp/output/* /output/.
if [ ! "${2:-}" == "0" ] && [ ! "${3:-}" == "0" ]; then
   sudo chown -R "${2}:${3}" /output/*
   sudo chmod -R 600 /output/*
fi
