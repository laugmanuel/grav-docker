#!/bin/sh

function yaml2json {
  ruby -rjson -ryaml -e 'puts YAML::load(STDIN.read).to_json'
}

echo "[+] Installing grav themes ..."

if [ -f ${PACKAGES_FILE} ]; then
  THEMES=$(cat ${PACKAGES_FILE} | yaml2json | jq -r '.themes | .[]' 2>/dev/null)

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
