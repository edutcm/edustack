# Edustack on Docker with Portainer

## Create external frontend network

```bash
docker network create -d bridged frontend # in stand-alone mode
docker network create -d overlay frontend # in swarm mode
```

## Start Traefik



## Start Portainer

```
docker run -d -p "8080:80" -v "${PWD}/templates.json:/usr/share/nginx/html/templates.json" portainer-templates
```