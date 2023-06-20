#!/bin/bash

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[93m'
WHITE='\033[97m'
BLUE='\033[34m'
NC='\033[0m'
BRED='\033[41m'
BGREEN='\033[42m'
BYELLOW='\033[43m'
BBLUE='\033[44m'
FRAME=${BBLUE}${WHITE}
SHADOW='\033[0;37m'

if [ -z "$COMPOSE" ]; then
    COMPOSE="docker compose"
fi

clear

options=("1: .env létrehozása" "2: DEV mód" "3: Compose up" "4: Artisan + NPM" "5: Migrate + Seed" "6: npm run dev" "7: Mindent lefuttat" "8: Kilépés" "9: Leállítás")

draw_frame() {
  clear
  for ((i = 0; i <= menu_height; i++)); do
    tput cup $((menu_y + i)) $menu_x
    if [[ $i -eq 0 ]]; then
      printf "${FRAME}╔%*s╗${NC}" $menu_width | sed 's/ /═/g'
    elif [[ $i -eq $((menu_height - 1)) ]]; then
      printf "${FRAME}╚%*s╝${SHADOW}█${NC}" $menu_width | sed 's/ /═/g'
    elif [[ $i -eq $menu_height ]]; then
      echo -ne "${NC} "
      printf "${SHADOW}%*s${NC}" $((menu_width + 2)) | sed 's/ /▀/g'
    else
      printf "${FRAME}║%*s║${SHADOW}█${NC}" $((menu_width)) ''
    fi
  done
}

MODE=dev

check() {
    case $1 in
      0)
        if [ -f ".env" ]; then
          echo -ne "${FRAME}[${GREEN}✓${FRAME}]${NC}"
        else
          echo -ne "${FRAME}[${RED}✕${FRAME}]${NC}"
        fi
      ;;
      1)
        if [ $MODE == "dev" ]; then
          echo -ne "${FRAME}[${GREEN}✓${FRAME}]${NC}"
        else
          echo -ne "${FRAME}[${RED}X${FRAME}]${NC}"
        fi
      ;;
      2)
        lines=$($COMPOSE ps | wc -l)
        if [ $lines -gt 1 ]; then
          echo -ne "${FRAME}[${GREEN}✓${FRAME}]${NC}"
        else
          echo -ne "${FRAME}[${RED}✕${FRAME}]${NC}"
        fi
      ;;
      3 | 4)
        echo -ne "${FRAME}[${YELLOW}?${FRAME}]${NC}"
        ;;
      5)
        if docker compose top | grep -q "npm run dev"; then
          echo -ne "${FRAME}[${GREEN}✓${FRAME}]${NC}"
        else
          echo -ne "${FRAME}[${RED}✕${FRAME}]${NC}"
        fi
      ;;
    esac
}

draw_options() {
  s="╡ Laravel Start ╞"
  sl=${#s}
  tput cup $((menu_y)) $((menu_x + ( menu_width - sl ) / 2 + 2))
  echo -ne "${FRAME}${s}"
  for ((i = 0; i < ${#options[@]}; i++)); do
    tput cup $((menu_y + 2 + i)) $((menu_x + 3))
    echo -ne "${FRAME}${options[$i]}${NC}"
    tput cup $((menu_y + 2 + i)) $((menu_x + menu_width - 4))
    check $i
  done
}

commands() {
    case $1 in
    1)
            cp .env.example .env 
      ;;
      2) 
        if [ $MODE == "dev" ]; then
            MODE="prod";
        else 
            MODE="dev";
        fi
        ;;
      3) $COMPOSE -f docker-compose.yml -f docker-compose.$MODE.yml up -d;;
      4) $COMPOSE exec app composer install
         $COMPOSE exec app php artisan key:generate
         $COMPOSE exec app npm install
        ;;
      5) $COMPOSE exec app php artisan migrate
         $COMPOSE exec app php artisan seed
         ;;
      6) $COMPOSE exec -d app npm run dev;;
    esac
}

while true; do
  cols=$(tput cols)
  rows=$(tput lines)
  menu_width=34
  menu_height=13
  menu_x=$(( (cols - menu_width) / 2 ))
  menu_y=$(( (rows - menu_height) / 2 ))

  draw_frame
  draw_options

  tput cup $((menu_y + menu_height + 1)) $((menu_x + 2))
  echo -e "Válassz opciót! (1-9):"

  read -r -n 1 choice

  if [[ $choice =~ ^[1-9]$ ]]; then
    tput cup $((menu_y + menu_height + 3)) $((menu_x + 2))
    case $choice in
      [1-6])
        commands $choice
        ;;
      7)
        commands 1
        commands 3
        commands 4
        commands 5
        commands 6
      ;;
      8) break;
      ;;
      9)
        read -n 1 -p "Biztos vagy benne? [i/N]" CH
        if [ $CH == 'i' ] || [ $CH == 'I' ]; then
          $COMPOSE down
        fi
      ;; 
    esac
  fi
done

clear
tput cnorm