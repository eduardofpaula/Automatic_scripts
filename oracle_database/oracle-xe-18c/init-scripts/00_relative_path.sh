#!/bin/bash

set -e

echo "Preparando paths dos sample schemas..."

cd /opt/oracle/sample-schemas
find . -type f \( -name "*.sql" -o -name "*.dat" \) -exec perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' {} +

echo "Paths dos sample schemas preparados com sucesso."