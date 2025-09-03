#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb