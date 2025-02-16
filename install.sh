#!/bin/sh

# Aggiorna il sistema
sudo pacman -Syu --noconfirm

# Installa pacchetti principali
sudo pacman -S --noconfirm --needed \
  brightnessctl qt5ct exa foot micro nemo hyprland ttf-jetbrains-mono waybar \
  otf-font-awesome terminus-font pamixer swaybg swaylock swayidle polkit-kde-agent \
  python-requests nemo-fileroller nemo-image-converter acpid mako gammastep mpv \
  blueman profile-sync-daemon imv swappy grim slurp xdg-desktop-portal-hyprland pacman-contrib gdm xf86-input-wacom onboard 

# Verifica se yay è installato, altrimenti installalo
if ! command -v yay >/dev/null; then
  echo "yay non trovato, installazione in corso..."
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

# Installa pacchetti AUR
yay --answerdiff None --answerclean None -S --noconfirm wob batsignal rofi-lbonn-wayland-git

# Installa driver per accelerazione hardware GPU
sudo pacman -S --noconfirm --needed intel-media-driver libva-mesa-driver mesa-vdpau libva-utils

# Installa altri software
sudo pacman -S --noconfirm --needed \
  telegram-desktop hugo gucharmap nodejs npm gnome-disk-utility code gprename \
  evince zramswap lazygit powertop htop

# Copia i file di configurazione se esistono
[ -d home ] && cp -r home/. ~/
[ -d etc ] && sudo cp -r etc/. /etc/

# Abilita servizi
sudo systemctl enable --now bluetooth.service
sudo systemctl enable paccache.timer
systemctl --user enable batsignal.service

sudo systemctl enable gdm.service

echo "Installazione completata!"
