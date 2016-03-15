#!/bin/bash

mkdir -p /tmp/output
sudo cp /import/config.json /tmp/config.json
sudo chmod a+r /tmp/config.json
vault-load.py
sudo cp -R /tmp/output/* /output/.
if [ ! "${2:-}" == "0" ] && [ ! "${3:-}" == "0" ]; then
   sudo chown -R "${2}:${3}" /output/*
   sudo chmod -R 600 /output/*
fi
