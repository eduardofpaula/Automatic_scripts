#!/bin/bash

echo "[INFO] Instalando Sample Schemas - versão simplificada..."

# Aguardar Oracle estar pronto
sleep 5

# Corrigir caminhos
docker exec oracle21c bash -c "cd /opt/oracle/sample-schemas && perl -p -i.bak -e 's#__SUB__CWD__#/opt/oracle/sample-schemas#g' *.sql */*.sql */*.dat 2>/dev/null || true"

# Instalar schemas
docker exec -u oracle oracle21c bash -c "
cd /opt/oracle/sample-schemas
echo '@mksample MinhaSenhaForte123@ MinhaSenhaForte123@ hr oe pm ix sh bi USERS TEMP /tmp/ ORCLPDB1' | sqlplus system/MinhaSenhaForte123@@ORCLPDB1
"

echo "[INFO] Instalação concluída!"