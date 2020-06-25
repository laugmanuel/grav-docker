# laugmanuel/docker-grav

[![badge1](https://img.shields.io/docker/cloud/build/laugmanuel/grav?style=flat-square&logo=appveyor)](https://hub.docker.com/r/laugmanuel/grav)
[![badge2](https://img.shields.io/docker/cloud/automated/laugmanuel/grav?style=flat-square&logo=appveyor)](https://hub.docker.com/r/laugmanuel/grav)
[![badge3](https://img.shields.io/docker/pulls/laugmanuel/grav?style=flat-square&logo=appveyor)](https://hub.docker.com/r/laugmanuel/grav)

# What is this repository?

This repository serves as a base for the `laugmanuel/grav` Docker image: https://github.com/laugmanuel/grav-docker

This image also allows for a dynamic installation during startup.

The image uses a sane nginx config from [h5bp](https://github.com/h5bp/server-configs-nginx) and some modified settings based on [GRAV Nginx hosting](https://learn.getgrav.org/16/webservers-hosting/servers/nginx).

# Information

- `FROM: alpine:stable`
- Nginx
- PHP7 + FPM
- GRAV core

# Example

```sh
docker run -p 8080:8080 \
  -v $(pwd)/grav-packages.yaml:/grav-packages.yaml:ro \
  -v $(pwd)/data/user:/usr/share/nginx/html/user \
  -v $(pwd)/data/backup:/usr/share/nginx/html/backup \
  -v $(pwd)/data/logs:/usr/share/nginx/html/logs \
  -it laugmanuel/grav:latest
```

# Variables

There are some environment variables which can be used to influence the behaviour:

### `FORCE_PLUGIN_INSTALL`

**Values:** `true` or `false` (**Default:** `false`)

Used to force the installation of all plugins. This also causes updates of the plugins.

### `FORCE_THEME_INSTALL`

**Values:** `true` or `false` (**Default:** `false`)

Used to force the installation of all themes. This also causes updates of the themes.

### `PACKAGES_FILE`

**Values:** \<path to packages file\> (**Default:** `/grav-packages.yaml`)

This file contains all plugins and themes in YAML syntax..
The plugins/themes will be installed during startup (if not already present).

**Example:**

```txt
themes:
  - future
plugins:
  - admin
  - simplesearch
  - youtube
```
