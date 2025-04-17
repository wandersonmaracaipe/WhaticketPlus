#! /bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[DEBUG] Caminho do script SYSTEM: ${SCRIPT_DIR}"
source ${SCRIPT_DIR}/../_general.sh

system_create_user() {
  print_banner
  printf "${WHITE} 💻 Agora, vamos criar o usuário para deploywhaticketplus...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  # Criar o usuário corretamente com senha criptografada e diretório home
  sudo useradd -m -p "$(openssl passwd -1 $deploy_password)" -s /bin/bash -G sudo deploywhaticketplus

  # Verifica se o usuário foi criado
  if id "deploywhaticketplus" &>/dev/null; then
    echo "✅ Usuário deploywhaticketplus criado com sucesso!"
  else
    echo "❌ Falha ao criar o usuário deploywhaticketplus!"
    exit 1
  fi

  # Agora, o usuário pode acessar o diretório de trabalho (/app)
  sudo chown -R deploywhaticketplus:deploywhaticketplus /app

  # Garantir que o usuário tenha permissões de sudo
  sudo usermod -aG sudo deploywhaticketplus

  # Garantir que o arquivo sudoers permita a execução sem senha
  grep -q "^deploywhaticketplus ALL=(ALL) NOPASSWD: ALL$" /etc/sudoers || echo "deploywhaticketplus ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

  sleep 2
}


system_execute_comand() {
  print_banner
  printf "${WHITE} 💻 Executando comandos...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  # Adicionar o usuário ao grupo sudo, caso não tenha sido feito anteriormente
  sudo usermod -aG sudo deploywhaticketplus

  # Instalar o ffmpeg
  sudo apt-get install -y ffmpeg

  # Garantir que a configuração do sudo seja feita corretamente
  grep -q "^deploywhaticketplus ALL=(ALL) NOPASSWD: ALL$" /etc/sudoers || echo "deploywhaticketplus ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

  sleep 2
}


# system_set_timezone() {
#   print_banner
#   printf "${WHITE} 💻 Setando Timezone...${GRAY_LIGHT}"
#   printf "\n\n"

#   sleep 2

#   sudo su - root <<EOF
#   timedatectl set-timezone America/Sao_Paulo
# EOF

#   sleep 2
# }

system_set_ufw() {
  print_banner
  printf "${WHITE} 💻 Liberando acesso a portas...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  ufw allow 3000/tcp 
  ufw allow 3003/tcp
EOF

  sleep 2
}

system_update() {
  print_banner
  printf "${WHITE} 💻 Vamos atualizar o sistema...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt -y update
  sudo apt-get install -y libxshmfence-dev libgbm-dev wget unzip fontconfig locales gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
EOF

  sleep 2
}
