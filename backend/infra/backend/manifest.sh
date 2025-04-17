#!/bin/bash

# Caminho absoluto do diretório onde o script está
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}"/_backend.db.sh
source "${SCRIPT_DIR}"/_backend.env.sh
source "${SCRIPT_DIR}"/_backend.node.sh
source "${SCRIPT_DIR}"/_backend.pm2.sh
source "${SCRIPT_DIR}"/_generate_config.sh
