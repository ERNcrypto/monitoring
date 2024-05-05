#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential git wget jq make gcc tmux pkg-config libssl-dev libleveldb-dev tar -y
ver="1.18.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
go version
sudo useradd -rs /bin/false tenderduty
cd $HOME
git clone https://github.com/blockpane/tenderduty
cd tenderduty
go install
cp example-config.yml config.yml
