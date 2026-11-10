# Imagen del bot de WhatsApp del CRM PRFN (Chromium + Node + entrypoint Pterodactyl)
#
# Por qué existe: los eggs de Pterodactyl no ejecutan el comando de arranque por sí
# solos; la imagen debe tener un entrypoint que lea la variable $STARTUP (así lo
# hacen las imágenes "yolks"). La imagen de Playwright trae Chromium pero NO ese
# entrypoint, por eso el bot no arrancaba en Sakura Host.
#
# Esta imagen parte de Node 22 slim e instala Chromium + el entrypoint compatible.

FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
      chromium \
      ca-certificates \
      fonts-liberation \
      fonts-dejavu-core \
      tini \
      iproute2 \
      procps \
    && rm -rf /var/lib/apt/lists/*

ENV USER=container \
    HOME=/home/container

WORKDIR /home/container

STOPSIGNAL SIGINT

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/entrypoint.sh"]
