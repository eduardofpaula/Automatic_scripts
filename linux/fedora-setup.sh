#!/bin/bash

# Script de configuração do Fedora
# Autor: Eduardo Farias
# Data: $(date)

# Este script configura um sistema Fedora com ferramentas basicas e aplicativos essenciais.
# Ele instala muitas ferramentas de desenvolvimento, configura o ambiente e instala aplicativos via Flatpak.
# CAUTELA: Este script foi feito para Fedora e pode não funcionar corretamente em outros sistemas operacionais.

set -e  # Interrompe o script em caso de erro

echo "🛠️ Iniciando configuração do Fedora..."

# Script feito somente para Fedora
if ! grep -qi "fedora" /etc/os-release; then
    echo "❌ Este script foi feito para Fedora. Sistema atual não suportado."
    exit 1
fi

# Atualizar o sistema
sudo dnf5 upgrade --refresh -y

# Habilitar RPM Fusion
echo "🔧 Habilitando RPM Fusion..."
sudo dnf5 install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Instalar pacotes básicos
sudo dnf5 install -y git curl wget unzip htop fastfetch
# Instalar Zsh, GNOME Tweaks e Flatpak
sudo dnf5 install -y zsh gnome-tweaks flatpak
# Instalar ferramentas de desenvolvimento
sudo dnf5 install -y gcc g++ make cmake
# Instalar Python 3 e pip
sudo dnf5 install -y python3 python3-pip
# Instalar Java 21, troque a versão conforme necessário
sudo dnf5 install -y java-21-openjdk java-21-openjdk-devel
# Instalar Node.js e Go
sudo dnf5 install -y nodejs golang

# Configurar GOPATH
echo "🔧 Configurando Go..."
mkdir -p "$HOME/go"
if ! grep -q "GOPATH" "$HOME/.bashrc"; then
    echo 'export GOPATH=$HOME/go' >> "$HOME/.bashrc"
    echo 'export PATH=$PATH:$GOPATH/bin' >> "$HOME/.bashrc"
fi

# Configurar Flatpak e instalar apps
# Adicionar repositório Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Lista de apps Flatpak para instalar
declare -a flatpak_apps=(
    "com.discordapp.Discord"
    "com.spotify.Client" 
    "com.mattjakeman.ExtensionManager"
    "io.github.flattool.Warehouse"
    "org.videolan.VLC"
    "md.obsidian.Obsidian"
    "io.dbeaver.DBeaverCommunity"
    "rest.insomnia.Insomnia"
    "com.jetbrains.IntelliJ-IDEA-Ultimate"
    "com.jetbrains.PyCharm-Professional"
    "me.iepure.devtoolbox"
    "io.github.giantpinkrobots.varia"
)

echo "📦 Instalando apps via Flatpak..."
for app in "${flatpak_apps[@]}"; do
    echo "  Instalando $app..."
    flatpak install -y flathub "$app" || echo "  ⚠️ Falha ao instalar $app"
done

# Instalar Visual Studio Code
echo "🖥️ Instalando Visual Studio Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf5 check-update
sudo dnf5 install -y code

# Instalar Docker
echo "🐳 Instalando Docker..."
# Remover versões antigas do Docker (comentado para evitar erros)
sudo dnf5 remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine

sudo dnf5 install -y dnf-plugins-core
sudo dnf5 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf5 install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker

# Adicionar usuário ao grupo docker se não estiver já
if ! groups "$USER" | grep -q docker; then
    sudo groupadd -f docker
    sudo usermod -aG docker "$USER"
    echo "  👤 Usuário $USER adicionado ao grupo docker"
fi

# Git config
echo "🔧 Configurando Git..."
read -p "Digite seu nome para o Git (ou pressione Enter para usar 'Eduardo Farias'): " git_name
read -p "Digite seu email para o Git (ou pressione Enter para usar 'eduardo.paula01@fatec.sp.gov.br'): " git_email

git_name=${git_name:-"eduardofpaula"}
git_email=${git_email:-"eduardo.paula01@fatec.sp.gov.br"}

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global init.defaultBranch main

echo "📝 Configurações aplicadas:"
echo "  Nome: $git_name"
echo "  Email: $git_email"

git config --list --show-origin

echo "✅ Setup concluído! Reinicie o sistema ou faça logout para aplicar todas as permissões e variáveis."
