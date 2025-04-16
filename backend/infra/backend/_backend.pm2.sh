#!/bin/bash

source ../_general.sh

# 5. Start via PM2
backend_start_pm2() {
  print_banner
  echo "${GREEN} 🚀 Iniciando PM2..."

  sudo su - deploywhaticketplus <<EOF
cd /home/deploywhaticketplus/whaticket/backend
pm2 start whaticketplus/server.js --name whaticket-backend
EOF
}

