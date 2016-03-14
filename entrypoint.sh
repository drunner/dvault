#!/bin/bash
if [ -e "/config/vars.sh" ]; then
   source "/config/vars.sh"
fi

exec "$@"
