#!/bin/sh

function yaml2json {
  ruby -rjson -ryaml -e 'puts YAML::load(STDIN.read).to_json'
}

echo "[+] Installing grav plugins ..."

if [ -f ${PACKAGES_FILE} ]; then
  PLUGINS=$(cat ${PACKAGES_FILE} | yaml2json | jq -r '.plugins | .[]' 2>/dev/null)
  THEMES=$(cat ${PACKAGES_FILE} | yaml2json | jq -r '.themes | .[]' 2>/dev/null)

  # Check all plugins
  for p in $PLUGINS; do
    if [ ! -d "${TARGET_PATH}/user/plugins/${p}" ] || [ "${FORCE_PLUGIN_INSTALL}" == "true" ]; then
      echo "  - Installing plugin: ${p}"
      ./bin/gpm install -qnyf ${p}
    else
      echo "  - Skipping plugin: ${p} - already present ..."
    fi
  done

  # Check all themes
  for t in $THEMES; do
    if [ ! -d "${TARGET_PATH}/user/themes/${t}" ] ||  [ "${FORCE_THEME_INSTALL}" == "true" ]; then
      echo "  - Installing theme: ${t}"
      ./bin/gpm install -qnyf ${t}
    else
      echo "  - Skipping theme: ${t} - already present ..."
    fi
  done
fi
