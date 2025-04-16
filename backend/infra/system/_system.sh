#! /bin/bash

source ../_general.sh


system_create_user() {
  print_banner
  printf "${WHITE} 💻 Agora, vamos criar o usuário para deploywhaticketplus...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  useradd -m -p $(openssl passwd $deploy_password) -s /bin/bash -G sudo deploywhaticketplus
  usermod -aG sudo deploywhaticketplus
  mv "${PROJECT_ROOT}"/whaticket.zip /home/deploywhaticketplus/
EOF

  sleep 2
}

system_execute_comand() {
  print_banner
  printf "${WHITE} 💻 Executando comandos...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  usermod -aG sudo deploywhaticketplus
  sudo apt install ffmpeg

  grep -q "^deploywhaticketplus ALL=(ALL) NOPASSWD: ALL$" /etc/sudoers || echo "deploywhaticketplus ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

  echo "deploywhaticketplus ALL=(ALL) NOPASSWD: ALL" | EDITOR='tee -a' visudo
  sudo apt install ffmpeg

EOF

  sleep 2 
}

system_set_timezone() {
  print_banner
  printf "${WHITE} 💻 Setando Timezone...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  timedatectl set-timezone America/Sao_Paulo
EOF

  sleep 2
}

system_set_ufw() {
  print_banner
  printf "${WHITE} 💻 Liberando acesso a portas...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  ufw allow 3000/tcp && 
  ufw allow 3003/tcp && 
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
