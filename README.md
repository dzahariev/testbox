# testbox

[![Build Status](https://travis-ci.org/dzahariev/testbox.svg?branch=main)](https://travis-ci.org/dzahariev/testbox)
[![Docker Repository on Quay](https://quay.io/repository/dzahariev/testbox/status "Docker Repository on Quay")](https://quay.io/repository/dzahariev/testbox)
[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/repository/docker/dzahariev/testbox)

Docker container with several tools that are needed for environment preparation and e2e tests execution:

- curl: https://curl.haxx.se
- git: https://git-scm.com
- CF Command line tool: https://github.com/cloudfoundry/cli
- UAA Command line tool: https://github.com/cloudfoundry/cf-uaac
- Oh My Zsh: https://github.com/ohmyzsh/ohmyzsh

## Build testbox:

```
cd github.com/dzahariev/testbox
docker build -t testbox .
```

## Start testbox:

```
docker run -it testbox
```

or

```
docker run -it quay.io/dzahariev/testbox:latest 

```

or

```
docker run -it dzahariev/testbox:latest 

```

## Remove testbox containers:

```
docker rm -fv $(docker ps -a -f "ancestor=testbox" --format "{{.ID}}")
```
