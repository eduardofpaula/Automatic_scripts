#!/bin/bash
# 
set -e

# 1. Build Oracle 21c Docker image
echo "[INFO] Building Oracle 21c Docker image..."
./buildContainerImage.sh -v 21.3.0 -e -t meu-oracle:21c-ee