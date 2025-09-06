#!/bin/bash
# 
set -e

# 1. Build Oracle 21c Docker image
echo "[INFO] Building Oracle 21c Docker image..."
./buildContainerImage.sh -v 21.3.0 -e -t meu-oracle:21c-ee

# 2. Criando diretórios necessários no host
echo "[INFO] Criando diretórios para XML e logs..."
mkdir -p /home/eduardo/oracle-dirs/oradata
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Jan
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Feb
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Mar
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Apr
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/May
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Jun
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Jul
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Aug
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Sep
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Oct
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Nov
mkdir -p /home/eduardo/oracle-dirs/home/OE/PurchaseOrders/2002/Dec
sudo chown -R 54321:54321 /home/eduardo/oracle-dirs
sudo chown -R 54321:54321 /home/eduardo/oracle-dirs/oradata

# 2. Subindo o container Oracle
docker run -d --name oracle21c \
  -p 1521:1521 -p 5500:5500 -p 2484:2484 \
  --ulimit nofile=1024:65536 --ulimit nproc=2047:16384 --ulimit stack=10485760:33554432 --ulimit memlock=3221225472 \
  -e ORACLE_SID=ORCLCDB \
  -e ORACLE_PDB=ORCLPDB1 \
  -e ORACLE_PWD=EduLindo123 \
  -e INIT_SGA_SIZE=4096 \
  -e INIT_PGA_SIZE=1024 \
  -e INIT_CPU_COUNT=4 \
  -e INIT_PROCESSES=300 \
  -e ORACLE_EDITION=enterprise \
  -e ORACLE_CHARACTERSET=AL32UTF8 \
  -e ENABLE_ARCHIVELOG=true \
  -e ENABLE_FORCE_LOGGING=true \
  -e ENABLE_TCPS=true \
  -v /home/eduardo/oracle-dirs/oradata:/opt/oracle/oradata \
  -v $(pwd)/21.3.0/init-scripts:/docker-entrypoint-initdb.d/startup \
  -v $(pwd)/21.3.0/db-sample-schemas-21.1:/opt/oracle/sample-schemas \
  -v /home/eduardo/oracle-dirs/home:/home \
  meu-oracle:21c-ee

############################
# ATÉ AQUI FUNCIONA BEM
############################

