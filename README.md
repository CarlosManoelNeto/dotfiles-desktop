# 🌲 Dotfiles Desktop (Hyprland + Gruvbox)

Repositório enxuto e automatizado de configurações para o ambiente de trabalho **Hyprland** no Arch Linux, com tema unificado **Gruvbox Dark** e fonte pixel-art **Monocraft**.

---

## 🚀 Como Restaurar após Formatar o PC

Após instalar o Arch Linux básico com internet e Git:

```bash
git clone https://github.com/CarlosManoelNeto/dotfiles-desktop.git ~/dotfiles-desktop
cd ~/dotfiles-desktop
./install.sh
```

O script `install.sh` é interativo e oferece:
1. Instalar todos os pacotes oficiais essenciais (`pacman`).
2. Instalar o `yay` e os pacotes do AUR (`brave-bin`, `spotify`, etc.).
3. Restaurar todos os arquivos de configuração em `~/.config/`.
4. Restaurar os scripts em `~/.local/bin/` com permissão de execução.
5. Instalar a fonte `Monocraft.ttf` e atualizar o cache do sistema.
6. Aplicar o tema `Gruvbox-BL-LB-Dark` e os papéis de parede.
7. Configurar o tema `pixie` no SDDM.

---

## 📦 Conteúdo do Repositório

```text
dotfiles-desktop/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.lua          # Configuração moderna do Hyprland (Lua)
│   │   ├── hypridle.conf         # Gerenciamento de ociosidade/bloqueio
│   │   ├── hyprlock.conf         # Tela de bloqueio personalizada Gruvbox
│   │   └── scripts/              # Script de alternância de wallpaper
│   ├── waybar/                   # Barra de status com controle de Spotify e volume
│   ├── rofi/                     # Lançador de aplicativos (Gruvbox + Monocraft)
│   ├── kitty/                    # Terminal configurado (Gruvbox + Monocraft)
│   ├── dunst/                    # Sistema de notificações
│   ├── satty/                    # Editor/anotador de capturas de tela
│   ├── gtk-3.0/ & gtk-4.0/       # Tema GTK (Gruvbox-BL-LB-Dark)
├── .local/
│   ├── bin/
│   │   ├── switch-audio.sh       # Troca rápida de saída de som (Fone / Caixas)
│   │   └── screenshot-*          # Scripts de captura de tela integrada ao Satty
│   └── share/fonts/
│       └── Monocraft.ttf         # Fonte do terminal e do menu
├── .themes/
│   └── Gruvbox-BL-LB-Dark/       # Tema GTK completo
├── etc/
│   └── sddm.conf.d/theme.conf    # Configuração do tema Pixie para o SDDM
├── home/
│   ├── .bashrc                   # Aliases e variáveis
│   └── .zshrc                    # Plugins (autosuggestions, syntax-highlight, starship)
├── wallpapers/                   # Papéis de parede integrados ao awww
├── core.txt                      # Pacotes oficiais essenciais
├── aur.txt                       # Pacotes essenciais do AUR
├── pkglist.txt                   # Backup de referência de todos os pacotes instalados
├── install.sh                    # Script de restauração automatizada
└── README.md
```

---

## ⌨️ Atalhos Principais (Hyprland)

| Tecla de Atalho | Ação |
| :--- | :--- |
| `SUPER + Q` | Abre o terminal (`kitty`) |
| `SUPER + D` | Abre o menu de aplicativos (`rofi`) |
| `SUPER + B` | Abre o navegador (`brave`) |
| `SUPER + E` | Abre o gerenciador de arquivos (`thunar`) |
| `SUPER + A` | **Alterna saída de áudio** (Fones ⇄ Caixas de som) |
| `SUPER + L` | **Bloqueia a tela** (`hyprlock`) |
| `SUPER + C` | Fecha a janela atual |
| `SUPER + F` | Alterna modo tela cheia |
| `SUPER + V` | Alterna janela flutuante |
| `Print` | **Captura de tela por seleção** (abre com o editor Satty) |
| `SHIFT + Print` | Captura de tela inteira (abre no Satty) |
| `CTRL + Print` | Captura da janela ativa (abre no Satty) |
| `SUPER + Print` | Captura de seleção direto para a área de transferência |
