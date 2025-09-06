#!/bin/bash
set -e

echo "[INFO] Parando e removendo todos os containers..."

ALL_CONTAINERS=$(docker ps -aq)

if [ -z "$ALL_CONTAINERS" ]; then
  echo "[INFO] Nenhum container encontrado."
  exit 0
fi

echo "[INFO] Containers encontrados:"
echo "$ALL_CONTAINERS"

echo "[INFO] Parando containers..."
docker stop $ALL_CONTAINERS >/dev/null

echo "[INFO] Removendo containers..."
docker rm $ALL_CONTAINERS >/dev/null

echo "[INFO] Concluído."
