#!/bin/sh

VERSION=$(curl -sq https://api.github.com/repos/getgrav/grav/releases/latest | jq -r '.tag_name')
TMP_DIR=$(mkdemp -d)

for p in grav grav-admin; do
  FILE="${p}-v${VERSION}.zip"
  curl -L --output "${TMP_DIR}/${FILE}" "https://github.com/getgrav/grav/releases/download/${VERSION}/${FILE}"
  unzip -d "${TMP_DIR}" "${TMP_DIR}/${p}"
done


# Start nginx
nginx -g "daemon off;"
