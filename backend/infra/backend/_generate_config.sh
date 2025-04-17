#!/bin/bash

CONFIG_DIR="/app/build/config"
CONFIG_FILE="$CONFIG_DIR/config.json"

generate_config () {
  # Lista das variáveis obrigatórias
  required_vars=(
    MYSQL_ROOT_PASSWORD
    DEPLOY_EMAIL
    DEPLOY_PASSWORD
    JWT_SECRET
    JWT_REFRESH_SECRET
    DB_HOST
    DB_USER
    DB_PASS
    DB_NAME
    DB_PORT
  )

  # Validação das variáveis obrigatórias
  for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
      echo "❌ Variável de ambiente $var não está definida."
      exit 1
    fi
  done

  # Garante que a pasta de destino exista
  mkdir -p "$CONFIG_DIR"

  # Cria o arquivo config.json com os valores das variáveis
  cat > "$CONFIG_FILE" <<EOF
{
  "development": {
    "username": "$DB_USER",
    "password": "$DB_PASS",
    "database": "$DB_NAME",
    "host": "$DB_HOST",
    "port": "$DB_PORT",
    "dialect": "postgres"
  }
}
EOF

  chmod 600 "$CONFIG_FILE"
  echo "✅ Arquivo $CONFIG_FILE criado com sucesso!"
}
