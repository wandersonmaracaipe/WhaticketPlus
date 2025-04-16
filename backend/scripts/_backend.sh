#!/bin/bash
#
# functions for setting up app backend
#######################################
# creates REDIS db using docker
# Arguments:
#   None
#######################################
backend_redis_create() {
  print_banner
  printf "${WHITE} 💻 Criando Redis ...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  usermod -aG docker deploywhaticketplus
  docker run --name redis-redis -p 6379:6379 --restart always --detach redis redis-server --requirepass ${db_pass}
  
EOF

  sleep 2

}

#######################################
# sets environment variable for backend.
# Arguments:
#   None
#######################################
backend_set_env() {
  print_banner
  printf "${WHITE} 💻 Configurando variáveis de ambiente (backend)...${GRAY_LIGHT}"
  printf "\n\n"
  sleep 2

  # Caminho do .env base
  ENV_FILE="../.env"

  # Verifica se o .env existe
  if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}Arquivo .env não encontrado em $ENV_FILE. Abortando.${GRAY_LIGHT}"
    exit 1
  fi

  # Se backend_url não foi setado, tenta obter do .env antigo
  if [[ -z "$backend_url" ]]; then
    backend_url=$(grep "^BACKEND_URL=" "$ENV_FILE" | cut -d '=' -f2-)
  fi

  # Se frontend_url não foi setado, tenta obter do .env antigo
  if [[ -z "$frontend_url" ]]; then
    frontend_url=$(grep "^FRONTEND_URL=" "$ENV_FILE" | cut -d '=' -f2-)
  fi

  # Garante idempotência (evita múltiplos https:// ou paths quebrados)
  backend_url=$(echo "${backend_url/https:\/\/}")
  backend_url=${backend_url%%/*}
  backend_url="https://$backend_url"

  frontend_url=$(echo "${frontend_url/https:\/\/}")
  frontend_url=${frontend_url%%/*}
  frontend_url="https://$frontend_url"

  # Copia o .env para a pasta correta
  sudo cp "$ENV_FILE" /home/deploywhaticketplus/whaticket/backend/.env
  sudo chown deploywhaticketplus:deploywhaticketplus /home/deploywhaticketplus/whaticket/backend/.env

  sleep 2
}


#######################################
# install_chrome
# Arguments:
#   None
#######################################
backend_chrome_install() {
  print_banner
  printf "${WHITE} 💻 Vamos instalar o Chrome...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  apt-get update
  apt-get install -y google-chrome-stable
EOF

  sleep 2
}

#######################################
# installs node.js dependencies
# Arguments:
#   None
#######################################
backend_node_dependencies() {
  print_banner
  printf "${WHITE} 💻 Instalando dependências do backend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploywhaticketplus <<EOF
  cd /home/deploywhaticketplus/whaticket/backend
  npm install --force
EOF

  sleep 2
}

#######################################
# runs db migrate
# Arguments:
#   None
#######################################
backend_db_migrate() {
  print_banner
  printf "${WHITE} 💻 Executando db:migrate...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploywhaticketplus <<EOF
  cd /home/deploywhaticketplus/whaticket/backend
  npx sequelize db:migrate
EOF

  sleep 2
}

#######################################
# runs db seed
# Arguments:
#   None
#######################################
backend_db_seed() {
  print_banner
  printf "${WHITE} 💻 Executando db:seed...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploywhaticketplus <<EOF
  cd /home/deploywhaticketplus/whaticket/backend
  npx sequelize db:seed:all
EOF

  sleep 2
}

#######################################
# starts backend using pm2 in 
# production mode.
# Arguments:
#   None
#######################################
backend_start_pm2() {
  print_banner
  printf "${WHITE} 💻 Iniciando pm2 (backend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploywhaticketplus <<EOF
  cd /home/deploywhaticketplus/whaticket/backend
  pm2 start whaticketplus/server.js --name whaticket-backend
EOF

  sleep 2
}

#######################################
# updates frontend code
# Arguments:
#   None
#######################################
backend_nginx_setup() {
  print_banner
  printf "${WHITE} 💻 Configurando nginx (backend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  backend_hostname=$(echo "${backend_url/https:\/\/}")

sudo su - root << EOF

cat > /etc/nginx/sites-available/whaticket-backend << 'END'
server {
  server_name $backend_hostname;

  location / {
    proxy_pass http://127.0.0.1:8080;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-Proto \$scheme;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_cache_bypass \$http_upgrade;
  }
}
END

ln -s /etc/nginx/sites-available/whaticket-backend /etc/nginx/sites-enabled
EOF

  sleep 2
}
