#! /usr/bin/env bash

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

apt install sudo

/sbin/usermod -aG sudo orveus

su - orveus

sudo apt remove docker docker-engine docker.io containerd runc

sudo apt update

sudo apt install ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

mkdir ssl

copy ssl_certificate.crt
copy ssl_certificate.key

mkdir database

sudo docker login
orveus 8RRt5qU3BP47xVaH

sudo docker-compose up

sudo chown -R $(sudo docker exec orveus-db id -u) database

command: /bin/sh -c "(/opt/mssql/bin/sqlservr &) && sleep 10s && /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $${SA_PASSWORD} -d master -Q 'CREATE DATABASE orveus;' && sleep infinity"

