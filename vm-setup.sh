# Docker

sudo apt update
sudo apt install git docker.io -y
sudo usermod -aG docker $USER
newgrp docker

# GNS3

sudo add-apt-repository ppa:gns3/ppa -y
sudo apt install gns3-gui -y

#fix wireshaork permissions

sudo chgrp $USER /usr/bin/dumpcap
sudo chmod 754 /usr/bin/dumpcap
sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap

# sudo apt install -y -qq debconf-utils
# echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
# sudo dpkg-reconfigure wireshark-common -fnoninteractive
# sudo chmod +x /usr/bin/dumpcap

echo "Restart your VM !"
