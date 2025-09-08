#!/bin/bash
# -----------------------------------------------------------------------------
# Script para build e inicialização do Oracle Database 21c em Docker
#
# Este script automatiza:
#   1. Build da imagem Docker do Oracle 21c (Enterprise Edition)
#   2. Criação dos diretórios necessários para persistência de dados e arquivos de exemplo
#   3. Inicialização do container Oracle com volumes e variáveis de ambiente apropriadas
#
# Requisitos:
#   - Docker instalado e rodando
#   - Permissão de sudo para criar diretórios e ajustar permissões
#   - Scripts e arquivos de schemas Oracle disponíveis no diretório do projeto
#
# Uso:
#   ./01_setup_oracle19c.sh [SENHA]
#   ou defina a variável de ambiente ORACLE_PWD
#
# Observações:
#   - Altere as paths conforme sua necessidade
#   - O usuário do Oracle dentro do container deve ter UID 54321 (padrão das imagens Oracle)
# -----------------------------------------------------------------------------

set -e

echo "[INFO] Usando senha do Oracle: $ORACLE_PWD"

# 1. Build da imagem Docker do Oracle 21c
echo "[INFO] Build da imagem Docker Oracle 21c..."
./buildContainerImage.sh -v 21.3.0 -e -t meu-oracle:21c-ee

# 2. Criação dos diretórios necessários no host para persistência e arquivos de exemplo
echo "[INFO] Criando diretórios para persistência de dados e arquivos de exemplo..."

mkdir -p "$HOME/oracle-dirs/oradata"
mkdir -p "$HOME/oracle-dirs/home/OE/PurchaseOrders"
mkdir -p "$HOME/oracle-dirs/home/OE/PurchaseOrders/2002"/{Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec}

# Ajusta permissões para o usuário padrão do Oracle no container (UID 54321)
sudo chown -R 54321:54321 "$HOME/oracle-dirs"
sudo chown -R 54321:54321 "$(pwd)/21.3.0/db-sample-schemas-21.1"

# 3. Inicialização do container Oracle
echo "[INFO] Inicializando container Oracle..."

docker run -d --name oracle21c \
  -p 1521:1521 -p 5500:5500 -p 2484:2484 \
  --ulimit nofile=1024:65536 --ulimit nproc=2047:16384 --ulimit stack=10485760:33554432 --ulimit memlock=3221225472 \
  -e ORACLE_SID=ORCLCDB \
  -e ORACLE_PDB=ORCLPDB1 \
  -e ORACLE_PWD="$ORACLE_PWD" \
  -e INIT_SGA_SIZE=4096 \
  -e INIT_PGA_SIZE=1024 \
  -e INIT_CPU_COUNT=4 \
  -e INIT_PROCESSES=300 \
  -e ORACLE_EDITION=enterprise \
  -e ORACLE_CHARACTERSET=AL32UTF8 \
  -e ENABLE_ARCHIVELOG=true \
  -e ENABLE_FORCE_LOGGING=true \
  -e ENABLE_TCPS=true \
  -v "$HOME/oracle-dirs/oradata:/opt/oracle/oradata" \
  -v "$(pwd)/21.3.0/init-scripts:/opt/oracle/scripts/startup" \
  -v "$(pwd)/21.3.0/db-sample-schemas-21.1:/opt/oracle/sample-schemas" \
  -v "$HOME/oracle-dirs/home:/home" \
  meu-oracle:21c-ee

echo "[INFO] Container Oracle iniciado. Aguardando inicialização completa..."
echo "[INFO] Você pode acompanhar os logs com: docker logs -f oracle21c"