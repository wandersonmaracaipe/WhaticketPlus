#! bin/bash 
# color
readonly RED="\033[1;31m"
readonly GREEN="\033[1;32m"
readonly BLUE="\033[1;34m"
readonly WHITE="\033[1;37m"
readonly YELLOW="\033[1;33m"
readonly GRAY_LIGHT="\033[0;37m"
readonly CYAN_LIGHT="\033[1;36m"
readonly RESET="\033[0m"
readonly BLACK="\033[0;30m"
readonly GRAY="\033[1;30m"
readonly GREEN_LIGHT="\033[0;32m"
readonly RED_LIGHT="\033[0;31m"
readonly ORANGE="\033[0;33m"
readonly PURPLE="\033[0;35m"
readonly BLUE_LIGHT="\033[0;34m"
readonly BROWN="\033[0;33m"
readonly LIGHT_GRAY="\033[0;37m"
readonly DARK_GRAY="\033[1;30m"
readonly LIGHT_RED="\033[1;31m"
readonly LIGHT_GREEN="\033[1;32m"

# thickness
readonly BOLD=$(tput bold)
readonly NORMAL=$(tput sgr0)

# Funções reutilizáveis
print_banner() {
  clear
  echo -e "${BOLD}${CYAN_LIGHT}"
  echo "╔═══════════════════════════════════════════════╗"
  echo "║         🚀 INSTALAÇÃO DO BACKEND 🚀           ║"
  echo "╚═══════════════════════════════════════════════╝"
  echo -e "${GRAY_LIGHT}"
}

# # Function to center and color text
# print_centered() {
#     local input="$1"
#     local color="$2"
#     local term_width=$(tput cols)
#     local text_width=${#input}

#     # Strip color codes for width calculation
#     local stripped_input=$(echo -e "$input" | sed 's/\x1b\[[0-9;]*m//g')
#     local stripped_width=${#stripped_input}

#     # Calculate padding
#     local pad_width=$(( (term_width - stripped_width) / 2 ))
#     local padding=$(printf '%*s' "$pad_width")

#     # Print with color and padding
#     echo -e "${padding}${color}${input}${Color_Off}"
# }