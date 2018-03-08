#!/bin/bash
# usage: ./install-docker-compose.sh <version>

if [ "$1" = "" ]
then
  echo "Please provide a version from https://github.com/docker/compose/releases/"
  exit 1
fi

echo "Installing version $1 to /usr/local/bin/docker-compose"
sudo curl -L https://github.com/docker/compose/releases/download/$1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
