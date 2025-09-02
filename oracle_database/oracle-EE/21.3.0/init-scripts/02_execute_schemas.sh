#!/bin/bash

echo "[INFO] Corrigindo caminhos nos scripts dentro do container..."
docker exec oracle21c bash -c "cd /opt/oracle/scripts/setup && perl -p -i.bak -e 's#__SUB__CWD__#/opt/oracle/scripts/setup#g' *.sql */*.sql */*.dat 2>/dev/null || true"
docker exec oracle21c bash -c "cd /opt/oracle/sample-schemas && perl -p -i.bak -e 's#__SUB__CWD__#/opt/oracle/sample-schemas#g' *.sql */*.sql */*.dat 2>/dev/null || true"

