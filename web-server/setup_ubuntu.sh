#!/usr/bin/env bash

# Change default setting
sudo timedatectl set-timezone UTC

# Pre-install commons softwares for Ubuntu server
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common unzip

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER
echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.bashrc && source ~/.bashrc
sudo tee -a /etc/wsl.conf <<EOF
[automount]
root = /
options = "metadata"
EOF

# Install docker-compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L "https://raw.githubusercontent.com/docker/compose/$DOCKER_COMPOSE_VERSION/contrib/completion/bash/docker-compose" -o /etc/bash_completion.d/docker-compose

echo "Install complete"