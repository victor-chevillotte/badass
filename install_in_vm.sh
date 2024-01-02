# Docker

sudo apt update
sudo apt install git docker.io -y
sudo usermod -aG docker $USER
newgrp docker

# GNS3

sudo add-apt-repository ppa:gns3/ppa -y
sudo apt install gns3-gui -y

echo "Restart your VM !"
