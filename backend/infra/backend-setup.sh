#!/bin/bash
# backend_setup.sh
# Script principal de instalação/configuração do backend Whaticket

# =====================================================

# reset shell colors
export TERM=xterm
tput init

# =====================================================
# Variáveis de ambiente
# Caminho absoluto do diretório onde o script está

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[INFO] Executando backend-setup.sh a partir de $SCRIPT_DIR"

# Define PROJECT_ROOT como base da infra
export PROJECT_ROOT="${SCRIPT_DIR}"

# Executa os manifests com caminhos absolutos
source "${PROJECT_ROOT}/backend/manifest.sh"
source "${PROJECT_ROOT}/system/manifest.sh"
source "${PROJECT_ROOT}/_general.sh"

# ====================================================
# SISTEMA

system_update
# system_set_timezone desativado pois o timezone já foi setado no docker-compose
# system_set_ufw desativado pois o ufw já foi setado no docker-compose (ports)
system_chrome_install
system_pm2_install
system_node_install
system_puppeteer_dependencies
system_sequelize_install

# system config
system_create_user
system_execute_comand

# ====================================================
# BACKEND


# system_unzip_whaticket 
# backend_set_env desativado pois o .env está completo antes do build e já foi injetado pelo docker-compose
backend_node_dependencies_install

generate_config
backend_db_init
backend_db_migrate
backend_db_seed

backend_start_pm2

