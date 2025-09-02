#!/bin/bash
# 
set -e

# 1. Build Oracle 21c Docker image
echo "[INFO] Building Oracle 21c Docker image..."
./buildContainerImage.sh -v 21.3.0 -e -t meu-oracle:21c-ee

docker run -d --name oracle21c \
  -p 1521:1521 -p 5500:5500 -p 2484:2484 \
  --ulimit nofile=1024:65536 --ulimit nproc=2047:16384 --ulimit stack=10485760:33554432 --ulimit memlock=3221225472 \
  -e ORACLE_SID=ORCLCDB \
  -e ORACLE_PDB=ORCLPDB1 \
  -e ORACLE_PWD=MinhaSenhaForte123@ \
  -e INIT_SGA_SIZE=4096 \
  -e INIT_PGA_SIZE=1024 \
  -e INIT_CPU_COUNT=4 \
  -e INIT_PROCESSES=300 \
  -e ORACLE_EDITION=enterprise \
  -e ORACLE_CHARACTERSET=AL32UTF8 \
  -e ENABLE_ARCHIVELOG=true \
  -e ENABLE_FORCE_LOGGING=true \
  -e ENABLE_TCPS=true \
  -v /home/eduardo/oradata:/opt/oracle/oradata \
  -v $(pwd)/21.3.0/init-scripts:/docker-entrypoint-initdb.d/startup \
  -v $(pwd)/21.3.0/db-sample-schemas-21.1:/opt/oracle/sample-schemas \
  meu-oracle:21c-ee

############################
# ATÉ AQUI FUNCIONA BEM
############################