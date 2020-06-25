#!/bin/sh

export FORCE_PLUGIN_INSTALL=${FORCE_PLUGIN_INSTALL:-false}
export FORCE_THEME_INSTALL=${FORCE_THEME_INSTALL:-false}
export PACKAGES_FILE=${PACKAGES_FILE:-/grav-packages.yaml}

export SOURCE_PATH="/grav/grav/"
export TARGET_PATH="/usr/share/nginx/html/"

echo "[+] docker-init.sh for grav setup"
echo "  - FORCE_PLUGIN_INSTALL: ${FORCE_PLUGIN_INSTALL}"
echo "  - FORCE_THEME_INSTALL: ${FORCE_THEME_INSTALL}"
echo "  - PACKAGES_FILE: ${PACKAGES_FILE}"
echo "  - Webroot: ${TARGET_PATH}"
echo "  - Package source: ${SOURCE_PATH}"

# Execute all scripts in /docker-init.d/
for file in /docker-init.d/*; do
  [ -f "${file}" ] && source "${file}"
done
