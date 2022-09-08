# Edustack on Docker with Portainer

## Using on Multipass

```bash
multipass launch docker --name docker -c 4 -m 4G -d 128G
multipass mount edustack docker:/home/ubunt/edustack

docker login # login to the docker cli to build and publish images
```

## Initial Swarm Setup

```bash
docker network create -d bridge frontend # standalone mode
docker volume create portainer_data      # portainer data volume
```

## Portainer deployment

### In Production

```bash
docker stack deploy -c portainer.yml portainer

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data portainer/portainer-ee:latest \
    --templates https://raw.githubusercontent.com/edutcm/edustack/main/templates.json
```

### In Development

```bash

```

## Added private registry

Add the jamfire private registry under Settings > Registries using a cli token.