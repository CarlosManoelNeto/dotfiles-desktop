#!/usr/bin/env bash
# ==============================================================================
# Script de Restauração Automatizada - Dotfiles Desktop (Hyprland + Gruvbox)
# ==============================================================================
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cores para feedback visual
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

echo -e "${BLUE}"
cat << "EOF"
  ____        _    __ _ _            ____            _    _             
 |  _ \  ___ | |_ / _(_) | ___  ___ |  _ \  ___  ___| | _| |_ ___  _ __  
 | | | |/ _ \| __| |_| | |/ _ \/ __|| | | |/ _ \/ __| |/ / __/ _ \| '_ \ 
 | |_| | (_) | |_|  _| | |  __/\__ \| |_| |  __/\__ \   <| || (_) | |_) |
 |____/ \___/ \__|_| |_|_|\___||___/|____/ \___||___/_|\_\\__\___/| .__/ 
                                                                  |_|    
EOF
echo -e "${NC}"
echo "Iniciando a restauração do ambiente de trabalho..."
echo

# 1. Instalação de Pacotes Oficiais
install_core_packages() {
    info "Instalando pacotes essenciais do sistema (pacman)..."
    if [ -f "$DIR/core.txt" ]; then
        PACKAGES=$(grep -vE '^\s*#|^\s*$' "$DIR/core.txt" | tr '\n' ' ')
        sudo pacman -S --needed --noconfirm $PACKAGES
        success "Pacotes oficiais instalados com sucesso!"
    else
        warn "Arquivo core.txt não encontrado."
    fi
}

# 2. Instalação do Yay (AUR Helper) se necessário
install_yay() {
    if ! command -v yay &> /dev/null; then
        info "yay não encontrado. Instalando yay a partir do repositório AUR..."
        sudo pacman -S --needed --noconfirm git base-devel
        TEMP_DIR=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$TEMP_DIR/yay"
        (cd "$TEMP_DIR/yay" && makepkg -si --noconfirm)
        rm -rf "$TEMP_DIR"
        success "yay instalado com sucesso!"
    fi
}

# 3. Instalação de Pacotes do AUR
install_aur_packages() {
    info "Instalando pacotes do AUR..."
    install_yay
    if [ -f "$DIR/aur.txt" ]; then
        AUR_PACKAGES=$(grep -vE '^\s*#|^\s*$' "$DIR/aur.txt" | tr '\n' ' ')
        yay -S --needed --noconfirm $AUR_PACKAGES
        success "Pacotes do AUR instalados com sucesso!"
    else
        warn "Arquivo aur.txt não encontrado."
    fi
}

# 4. Copiar Arquivos de Configuração (.config)
restore_configs() {
    info "Restaurando configurações em ~/.config..."
    mkdir -p "$HOME/.config"
    cp -r "$DIR/.config/"* "$HOME/.config/"
    success "Configurações restauradas (Hyprland, Waybar, Rofi, Kitty, Dunst, Satty, GTK)."
}

# 5. Copiar Scripts Pessoais (.local/bin)
restore_scripts() {
    info "Restaurando scripts em ~/.local/bin..."
    mkdir -p "$HOME/.local/bin"
    cp -r "$DIR/.local/bin/"* "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/"*
    success "Scripts de screenshot e troca de áudio restaurados e com permissão de execução."
}

# 6. Copiar Fontes (Monocraft)
restore_fonts() {
    info "Restaurando fontes em ~/.local/share/fonts..."
    mkdir -p "$HOME/.local/share/fonts"
    cp -r "$DIR/.local/share/fonts/"* "$HOME/.local/share/fonts/"
    fc-cache -fv > /dev/null 2>&1 || true
    success "Fonte Monocraft instalada e cache de fontes atualizado."
}

# 7. Copiar Temas (.themes)
restore_themes() {
    info "Restaurando tema Gruvbox em ~/.themes..."
    mkdir -p "$HOME/.themes"
    cp -r "$DIR/.themes/"* "$HOME/.themes/"
    success "Tema Gruvbox-BL-LB-Dark restaurado com sucesso."
}

# 8. Copiar Papéis de Parede
restore_wallpapers() {
    info "Restaurando papéis de parede em ~/wallpapers..."
    mkdir -p "$HOME/wallpapers"
    cp -r "$DIR/wallpapers/"* "$HOME/wallpapers/"
    success "Wallpapers restaurados."
}

# 9. Copiar Shell Configs (bash & zsh)
restore_shell() {
    info "Restaurando configurações do shell (.zshrc e .bashrc)..."
    [ -f "$DIR/home/.bashrc" ] && cp "$DIR/home/.bashrc" "$HOME/.bashrc"
    [ -f "$DIR/home/.zshrc" ] && cp "$DIR/home/.zshrc" "$HOME/.zshrc"
    success "Shells configurados."
}

# 10. Configuração do SDDM (Tema Pixie)
restore_sddm() {
    if [ -f "$DIR/etc/sddm.conf.d/theme.conf" ]; then
        info "Configurando tema do SDDM (/etc/sddm.conf.d/theme.conf)..."
        sudo mkdir -p /etc/sddm.conf.d
        sudo cp "$DIR/etc/sddm.conf.d/theme.conf" /etc/sddm.conf.d/theme.conf
        sudo systemctl enable sddm.service 2>/dev/null || true
        success "SDDM configurado para utilizar o tema pixie!"
    fi
}

# Menu de Opções
if [ "$1" == "--all" ] || [ "$1" == "-y" ]; then
    install_core_packages
    install_aur_packages
    restore_configs
    restore_scripts
    restore_fonts
    restore_themes
    restore_wallpapers
    restore_shell
    restore_sddm
else
    echo "Escolha o que deseja restaurar:"
    echo "  1) Restaurar TUDO (Pacotes oficiais, AUR, Configs, Scripts, Fontes, Temas, SDDM)"
    echo "  2) Apenas Arquivos de Configuração e Scripts (sem instalar pacotes)"
    echo "  3) Apenas Pacotes (Oficiais + AUR)"
    echo "  4) Sair"
    echo
    read -rp "Opção [1-4]: " OPCAO

    case "$OPCAO" in
        1)
            install_core_packages
            install_aur_packages
            restore_configs
            restore_scripts
            restore_fonts
            restore_themes
            restore_wallpapers
            restore_shell
            restore_sddm
            ;;
        2)
            restore_configs
            restore_scripts
            restore_fonts
            restore_themes
            restore_wallpapers
            restore_shell
            ;;
        3)
            install_core_packages
            install_aur_packages
            ;;
        *)
            info "Operação cancelada."
            exit 0
            ;;
    esac
fi

echo
success "Restauração finalizada com sucesso! Reinicie a sessão para carregar todas as alterações."
