#!/bin/sh

echo "[+] Installing grav plugins ..."

if [ -f ${PLUGIN_FILE} ]; then
  PLUGINS=$(cat ${PLUGIN_FILE} | xargs)
  PLUGINS_INSTALLED=true

  # Check if there are plugins missing
  for p in $PLUGINS; do
    if [ ! -d "${TARGET_PATH}/user/plugins/${p}" ]; then
      PLUGINS_INSTALLED=false
    fi
  done

  # If plugins are missing or install is forced we do so
  if [ "${PLUGINS_INSTALLED}" == "false" ] || [ "${FORCE_PLUGIN_INSTALL}" == "true" ]; then
    (
      cd ${TARGET_PATH}
      ./bin/gpm install -f -y ${PLUGINS}
    )
  else
    echo "  - Skipping Plugin installation. They are already present..."
  fi
fi
