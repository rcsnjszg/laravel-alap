#!/bin/sh

if [ -f ".env" ]; then
    echo ".env fájl már létezik!"
else 
    cp .env.example .env
fi

if [ "$1" ]; then
  MODE=$1
else
  MODE=dev
fi

# shopt -s expand_aliases

docker compose -f docker-compose.yml -f docker-compose.$MODE.yml  up -d
docker compose exec app artisan key:generate
docker compose exec app composer install
docker compose exec app npm install