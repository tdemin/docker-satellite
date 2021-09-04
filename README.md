# Satellite Docker image

[![Build & push to GHCR](https://github.com/tdemin/docker-satellite/actions/workflows/docker.yml/badge.svg)](https://github.com/tdemin/docker-satellite/actions/workflows/docker.yml)

This repo holds [Satellite](https://git.sr.ht/~gsthnz/satellite), a Project Gemini static file
server software, Docker build recipe with GitHub Actions.

The latest version tag is rebuilt daily at UTC 00:00 to ensure the latest dependencies / OS
versions.

You can pull the latest tagged version of Satellite:

```
% docker pull ghcr.io/tdemin/docker-satellite:latest
```

or the specific tag:

```
% docker pull ghcr.io/tdemin/docker-satellite:v1.0.0
```

## Usage

Create two directories to store certs/configuration and data served by satellite (Satellite runs
under UID 1000, so we need to grant it RWX on the config dir), then run the container:

```
% mkdir config
% mkdir data
% cat >config/config.toml <<EOF
[tls]
directory = "/config"
[[domain]]
name = "example.org"
root = "/data"
EOF
% chown 1000 config
% chmod 700 config
% docker run -d -p 1965:1965 -v $(pwd)/config:/config \
    -v $(pwd)/data:/data ghcr.io/tdemin/docker-satellite
```
