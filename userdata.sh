#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo snap install docker
sudo systemctl start docker
# sudo usermod -aG sudo $USER
# sudo usermod -aG docker $USER
sudo systemctl restart docker
sudo apt install docker-compose -y



