#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../_general.sh

system_node_install() {
  print_banner
  printf "${WHITE} 💻 Verificando instalação do Node.js...${GRAY_LIGHT}\n\n"

  if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node -v)
    echo "✅ Node.js já está instalado: $NODE_VERSION"
  else
    echo "🔧 Node.js não encontrado. Instalando..."

    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sleep 2
    npm install -g npm@latest
    sleep 2
  fi
}
