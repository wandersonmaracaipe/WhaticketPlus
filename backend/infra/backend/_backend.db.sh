#!/bin/bash

source ../_general.sh

# 4. Migrations e Seeds
backend_db_migrate() {
  print_banner
  echo "${YELLOW} 🗂️  Rodando migrations..."

  sudo su - deploywhaticketplus <<EOF
cd /home/deploywhaticketplus/whaticket/backend
npx sequelize db:migrate
EOF
}

backend_db_seed() {
  print_banner
  echo "${YELLOW} 🌱 Rodando seeds..."

  sudo su - deploywhaticketplus <<EOF
cd /home/deploywhaticketplus/whaticket/backend
npx sequelize db:seed:all
EOF
}
