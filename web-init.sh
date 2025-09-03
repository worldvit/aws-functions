#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo '<h1>Hello from a Terraform file()!</h1>' | sudo tee /var/www/html/index.html