#!/bin/bash

# Caminho absoluto do diretório onde o script está
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}"/_install.chrome.sh
source "${SCRIPT_DIR}"/_install.node.sh
source "${SCRIPT_DIR}"/_install.sequelize.sh
source "${SCRIPT_DIR}"/_install.pm2.sh
source "${SCRIPT_DIR}"/_install.puppeteer.sh
source "${SCRIPT_DIR}"/_system.sh
