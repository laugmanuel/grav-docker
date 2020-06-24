#!/bin/sh

export FORCE_PLUGIN_INSTALL=${FORCE_PLUGIN_INSTALL:-false}
export PLUGIN_FILE=${PLUGIN_FILE:-/grav-plugins.txt}

export SOURCE_PATH="/grav/grav/"
export TARGET_PATH="/usr/share/nginx/html/"

echo "[+] docker-init.sh for grav setup"
echo "  - FORCE_PLUGIN_INSTALL: ${FORCE_PLUGIN_INSTALL}"
echo "  - PLUGIN_FILE: ${PLUGIN_FILE}"
echo "  - Webroot: ${TARGET_PATH}"
echo "  - Package source: ${SOURCE_PATH}"

# Execute all scripts in /docker-init.d/
for file in /docker-init.d/*; do
  [ -f "${file}" ] && source "${file}"
done
