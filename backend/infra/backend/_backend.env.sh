#!/bin/bash

# _backend.env.sh

source ../_general.sh

# 1. Setar variáveis de ambiente
backend_set_env() {
  print_banner
  echo -e "${YELLOW}🔧 Configurando variáveis de ambiente...${RESET}"

  ENV_FILE="../.env"

  if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}❌ Arquivo .env não encontrado.${RESET}"
    exit 1
  fi

  backend_url=$(grep "^BACKEND_URL=" "$ENV_FILE" | cut -d '=' -f2-)
  frontend_url=$(grep "^FRONTEND_URL=" "$ENV_FILE" | cut -d '=' -f2-)

  backend_url="https://${backend_url//https:\/\/}"
  frontend_url="https://${frontend_url//https:\/\/}"

  sudo cp "$ENV_FILE" /home/deploywhaticketplus/whaticket/backend/.env
  sudo chown deploywhaticketplus:deploywhaticketplus /home/deploywhaticketplus/whaticket/backend/.env

  echo -e "${GREEN}✅ Variáveis de ambiente configuradas com sucesso.${RESET}"
  sleep 2
}
