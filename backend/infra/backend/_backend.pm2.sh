#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../_general.sh

# 5. Start via PM2
backend_start_pm2() {
  print_banner
  echo "${GREEN} 🚀 Iniciando PM2 com pm2-runtime no foreground..."

  # Inicia o app com PM2 em foreground (modo Docker-friendly)
  exec pm2-runtime start /app/build/whaticketplus/server.js --name whaticket-backend
}

