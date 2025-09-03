#!/bin/bash
set -e

echo "[INFO] Preparando paths dos sample schemas..."

echo "[INFO] Owner atual:"
ls -ld /opt/oracle/sample-schemas || true

echo "[INFO] Tentando criar diretório de log..."
if ! mkdir -p /opt/oracle/sample-schemas/log 2>/dev/null; then
  echo "[ERRO] Sem permissão para criar /opt/oracle/sample-schemas/log"
  echo "[DICA] Execute no host: sudo chown -R 54321:54321 21.3.0/db-sample-schemas-21.1"
  exit 0
fi

echo "[INFO] Diretório de log OK."

echo "[INFO] Corrigindo paths dos sample schemas..."

cd /opt/oracle/sample-schemas
perl -p -i.bak -e 's#__SUB__CWD__#/opt/oracle/sample-schemas#g' *.sql */*.sql */*.dat

echo "[INFO] Paths corrigidos."