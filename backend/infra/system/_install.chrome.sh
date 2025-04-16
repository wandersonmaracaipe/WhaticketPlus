#!/bin/bash

source ../_general.sh

system_chrome_install() {
  print_banner
  echo -e "${BLUE} 🌐 Instalando Google Chrome..."

  if command -v google-chrome >/dev/null 2>&1; then
    echo -e "${GREEN} ✅ Chrome já está instalado. Pulando etapa."
    return
  fi

  # Adiciona o repositório apenas se ainda não existir
  if [ ! -f /etc/apt/sources.list.d/google-chrome.list ]; then
    echo "${YELLOW} 🔧 Adicionando repositório do Chrome..."
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
      | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

    # Importa chave com segurança moderna
    wget -q -O- https://dl.google.com/linux/linux_signing_key.pub \
      | gpg --dearmor | sudo tee /usr/share/keyrings/google-linux-signing-key.gpg > /dev/null
  fi

  echo "${YELLOW} 📦 Atualizando pacotes e instalando google-chrome-stable..."
  sudo apt-get update
  sudo apt-get install -y google-chrome-stable

  echo "${GREEN} ✅ Google Chrome instalado com sucesso."
}
