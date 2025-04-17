#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../_general.sh

system_sequelize_install() {
  print_banner
  printf "${WHITE} 💻 Instalando Sequelize-cli...${GRAY_LIGHT}"
  printf "\n\n"

  sudo npm install -g sequelize-cli

  sleep 2
}