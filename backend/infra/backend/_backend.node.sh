#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../_general.sh


# 3. Instalar dependências do Node
backend_node_dependencies_install() {
  print_banner
  echo -e "${YELLOW} 📦 Instalando dependências do backend..."

  sudo su - deploywhaticketplus <<EOF
cd /app/build
npm install --legacy-peer-deps
EOF
}