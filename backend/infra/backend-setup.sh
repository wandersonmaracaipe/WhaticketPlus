#!/bin/bash
# backend_setup.sh
# Script principal de instalação/configuração do backend Whaticket

# Importa funções e variáveis
source ./backend/manifest.sh
source ./system/manifest.sh
source ./_banner.sh

# reset shell colors
tput init 

# ====================================================
# SISTEMA

system_update
system_set_timezone
system_set_ufw
system_chrome_install
system_pm2_install
system_node_install
system_puppeteer_dependencies

# system config
system_create_user
system_execute_comand

# ====================================================
# BACKEND

system_unzip_whaticket
# backend_set_env desativado pois o .env está completo antes do build e já foi injetado pelo dockercompose
backend_node_dependencies_install
backend_db_migrate
backend_db_seed
backend_start_pm2

