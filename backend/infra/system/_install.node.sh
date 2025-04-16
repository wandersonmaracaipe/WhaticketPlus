#!/bin/bash

source ../_general.sh

system_node_install() {
  print_banner
  printf "${WHITE} 💻 Instalando o Node.js...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  apt-get install -y nodejs
  sleep 2
  npm install -g npm@latest
  sleep 2
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update -y && sudo apt-get -y install postgresql
  sleep 2
  sudo timedatectl set-timezone America/Sao_Paulo
  sleep 2
  sudo -u postgres psql -c "ALTER USER postgres PASSWORD '2000@23';"
  sudo -u postgres psql -c "CREATE DATABASE whaticketwhaticketplus;"
  exit
EOF

  sleep 2
}
