#!/bin/sh

BLUE='\033[0;34m'
NC='\033[0m'

printf "${BLUE}[mkcert]${NC} generating mkcert certificates..."
mkcert -cert-file ./local-cert.pem -key-file ./local-key.pem docker.local "*.docker.local"
mkcert -install