#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../_general.sh

# 4. Migrations e Seeds
backend_db_init() {
  print_banner
  echo "${YELLOW} 🗂️  Iniciando sequelize..."

  cd /app/build

  sudo npx sequelize-cli init 2>&1 | tee /var/log/backend/db_init.log
}

backend_db_migrate() {
  print_banner
  echo "${YELLOW} 🗂️  Rodando migrations..."

  cd /app/build

  sudo npx sequelize-cli db:migrate 2>&1 | tee /var/log/backend/db_migrations.log
}

backend_db_seed() {
  print_banner
  echo "${YELLOW} 🌱 Rodando seeds..."

  cd /app/build

  sudo npx sequelize-cli db:seed:all 2>&1 | tee /var/log/backend/db_seeds.log
}
