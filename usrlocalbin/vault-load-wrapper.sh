#!/bin/bash

mkdir -p /tmp/output
vault-load.py "$1"
sudo cp -R /tmp/output/* /load/.
if [ ! "${2:-}" == "0" ] && [ ! "${3:-}" == "0" ]; then
   sudo chown -R "${2}:${3}" /load/*
   sudo chmod -R 600 /load/*
fi
