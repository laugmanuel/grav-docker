# laugmanuel/docker-grav

<Docker Hub Badge>

# What is this repository?

This repository serves as a base for the `laugmanuel/grav` Docker image: https://github.com/laugmanuel/grav-docker

This image also allows for a dynamic installation during startup.

# Information

- `FROM: alpine:stable`
- Nginx
- PHP7 + FPM
- GRAV core

# Example
```sh
docker run -p 8080:8080 \
  -v $(pwd)/grav-plugins.txt:/grav-plugins.txt:ro \
  -v $(pwd)/data:/usr/share/nginx/html \
  -it laugmanuel/grav:latest
```

# Variables

There are some environment variables which can be used to influence the behaviour:

### `FORCE_PLUGIN_INSTALL`

**Values:** `true` or `false` (**Default:** `false`)

Used to force the installation of all plugins. This also causes updates of the plugins.

### `PLUGIN_FILE`

**Values:** \<path to plugins file\> (**Default:** `/grav-plugins.txt`)

This file contains all plugins line by line.
The plugins will be installed during startup (if not already present).

**Example:**

```txt
admin
simplesearch
youtube
```
