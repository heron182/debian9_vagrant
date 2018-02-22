#!/usr/bin/env bash

initial_setup () {
    echo Initializing...
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    python-pip \
    python3-pip
}

docker_add_repository() {
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable"
}

docker_compose_install() {
    sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

docker_install () {
    echo Installing docker...
    docker_add_gpg_key
    docker_add_repository
    sudo apt-get update -y
    sudo apt-get install -y docker-ce
    docker_compose_install
}


initial_setup
docker_install
