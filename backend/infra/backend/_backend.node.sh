#!/bin/bash

source ../_general.sh     

# 3. Instalar dependências do Node
backend_node_dependencies_install() {
  print_banner
  echo -e "${YELLOW} 📦 Instalando dependências do backend..."

  sudo su - deploywhaticketplus <<EOF
cd /home/deploywhaticketplus/whaticket/backend
npm install --force
EOF
}