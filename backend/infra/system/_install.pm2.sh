#!/bin/bash

source ../_general.sh

system_pm2_install() {
  print_banner
  printf "${WHITE} 💻 Instalando pm2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  npm install -g pm2
  pm2 startup ubuntu -u deploywhaticketplus
  env PATH=\$PATH:/usr/bin pm2 startup ubuntu -u deploywhaticketplus --hp /home/deploywhaticketplus
EOF

  sleep 2 
}