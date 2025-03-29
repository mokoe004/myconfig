#!/bin/bash

# === setup_main_2204.sh ===
# Ubuntu 22.04 - Full Desktop Environment for Daily Use + Dev Tools

set -e

# Update system
echo "\n📦 Updating system..."
sudo apt update && sudo apt upgrade -y

# Essentials
sudo apt install -y git curl wget gpg build-essential software-properties-common apt-transport-https ca-certificates net-tools htop unzip

# Snap + Flatpak
sudo apt install -y snapd flatpak gnome-software-plugin-flatpak

# Docker
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update && sudo apt install -y code
rm microsoft.gpg

# PyCharm
sudo snap install pycharm-professional --classic

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Communication
sudo snap install spotify
sudo snap install webcord
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb

# VPN & Security
sudo apt install -y openconnect network-manager-openconnect-gnome wireguard openvpn
sudo apt install -y ausweisapp2

# Sciebo / ownCloud
sudo add-apt-repository ppa:nextcloud-devs/client -y
sudo apt update && sudo apt install -y owncloud-client

# PDF Tools
sudo apt install -y pdfarranger

# Miniconda
cd /tmp
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
$HOME/miniconda/bin/conda init zsh
conda init
conda config --set auto_activate_base false
conda install -y jupyterlab numpy pandas matplotlib scipy
pip install virtualenv pipx


# Virt-Manager for Windows VM
sudo apt install -y virt-manager qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER

# UI Tweaks
# Windows-like Shortcuts

gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

# Aliases
echo "alias ll='ls -lah'" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc

# Final cleanup
echo "\n✅ Setup complete! Please reboot or re-login for all group changes to take effect."
