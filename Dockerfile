FROM node:18-alpine AS builder
ENV BUILDTIME_ENV_EXAMPLE=${BUILDTIME_ENV_EXAMPLE}

EXPOSE 3000
WORKDIR /app
ADD file.tar.gz /app/

RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb &&\
    chmod +x web.js

ENTRYPOINT [ "node", "server.js" ]
