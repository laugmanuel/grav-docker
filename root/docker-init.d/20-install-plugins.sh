#!/bin/sh

function yaml2json {
  ruby -rjson -ryaml -e 'puts YAML::load(STDIN.read).to_json'
}

echo "[+] Installing grav plugins ..."

if [ -f ${PACKAGES_FILE} ]; then
  PLUGINS=$(cat ${PACKAGES_FILE} | yaml2json | jq -r '.plugins | .[]' 2>/dev/null)

  # Check all plugins
  for p in $PLUGINS; do
    if [ ! -d "${TARGET_PATH}/user/plugins/${p}" ] || [ "${FORCE_PLUGIN_INSTALL}" == "true" ]; then
      echo "  - Installing plugin: ${p}"
      ./bin/gpm install -qnyf ${p}
    else
      echo "  - Skipping plugin: ${p} - already present ..."
    fi
  done
fi
