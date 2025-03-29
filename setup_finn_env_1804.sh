#!/bin/bash

# === setup_finn_env_1804.sh ===
# Purpose: Prepare minimal Ubuntu 18.04 environment to run FINN via Docker
# Assumes: Xilinx tools are manually installed
# By: ChatGPT + You 💻🚀

set -e

echo "📦 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🧰 Installing essential tools..."
sudo apt install -y \
    git curl wget gpg build-essential \
    apt-transport-https ca-certificates software-properties-common \
    net-tools htop unzip

echo "🐳 Installing Docker (no root access)..."
sudo apt install -y docker.io
sudo usermod -aG docker $USER

echo "⚙️ Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "🧠 Setting environment variables for FINN..."
# You must adjust these paths to match your system!
echo 'export FINN_XILINX_PATH=/opt/Xilinx' >> ~/.bashrc
echo 'export FINN_XILINX_VERSION=2022.2' >> ~/.bashrc

# Apply them to current shell
export FINN_XILINX_PATH=/opt/Xilinx
export FINN_XILINX_VERSION=2022.2

echo "📁 Cloning FINN repo..."
mkdir -p ~/tools
cd ~/tools
git clone https://github.com/Xilinx/finn.git
cd finn

echo "✅ FINN repo ready. You can now run:"
echo "    ./run-docker.sh quicktest"
echo ""
echo "🎯 To launch Jupyter notebooks:"
echo "    ./run-docker.sh notebook"
echo ""
echo "💡 Tip: You can create a custom script like run-finn.sh with all env vars preset."

echo "🚀 All done. Please reboot or log out/in for Docker permissions to take effect."
