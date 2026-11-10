#!/bin/bash
# Entrypoint compatible con Pterodactyl (mismo comportamiento que las imágenes yolks).
cd /home/container || exit 1

export HOME=/home/container

# Pterodactyl pasa el comando de arranque del servidor en $STARTUP.
if [ -z "${STARTUP}" ]; then
  echo "[:/home/container] No se recibió STARTUP; abriendo shell."
  exec /bin/bash
fi

MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"
eval "${MODIFIED_STARTUP}"
