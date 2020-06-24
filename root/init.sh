#!/bin/sh

FORCE_PLUGIN_INSTALL=${FORCE_PLUGIN_INSTALL:-false}
PLUGIN_FILE=${PLUGIN_FILE:-/grav-plugins.txt}

echo "$0 script for GRAV setup!"
echo "  - FORCE_PLUGIN_INSTALL: ${FORCE_PLUGIN_INSTALL}"
echo "  - PLUGIN_FILE: ${PLUGIN_FILE}"

cd /usr/share/nginx/html/

# Check for every directory
for p in /grav/grav/ /usr/share/nginx/html; do
  if [ ! -d "${p}" ]; then
    echo "${p} -- directory not found!"
    exit 1
  fi
done

# Install GRAV to target directory
cp -af /grav/grav/* /grav/grav/.[!.]* /usr/share/nginx/html/

# Install Plugins
if [ -f ${PLUGIN_FILE} ]; then
  PLUGINS=$(cat ${PLUGIN_FILE} | xargs)
  PLUGINS_INSTALLED=true

  for p in $PLUGINS; do
    if [ ! -d "./user/plugins/${p}" ]; then
      PLUGINS_INSTALLED=false
    fi
  done

  if [ "${PLUGINS_INSTALLED}" == "false" ] || [ "${FORCE_PLUGIN_INSTALL}" == "true" ]; then
    ./bin/gpm install -f -y ${PLUGINS}
  fi
fi

# Fix permissions
chown -R nginx:nginx ./* ./.*
find . -type f | xargs chmod 664
find ./bin -type f | xargs chmod 775
find . -type d | xargs chmod 775
find . -type d | xargs chmod +s
umask 0002

# Start services
php-fpm7 --daemonize
nginx -g "daemon off;"
