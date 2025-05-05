# Usa la imagen base de Node.js con Debian Bookworm (la misma que en tu devcontainer.json)
FROM mcr.microsoft.com/devcontainers/typescript-node:1-20-bookworm

# Cambia a root para todas las operaciones de instalación
USER root

# Instala Chromium y sus dependencias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    chromium \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Usa nvm para instalar y establecer Node.js 20.10.0
RUN su node -c "source /usr/local/share/nvm/nvm.sh && \
    nvm install 20.10.0 && \
    nvm use 20.10.0 && \
    npm install -g @angular/cli@18"

# Configura variables de entorno para Chromium
ENV CHROME_BIN=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
# Expone el puerto 4200 (Angular CLI)
EXPOSE 4200
# Establece el usuario root por defecto (elimina esta línea si prefieres ejecutar como node)
USER root

