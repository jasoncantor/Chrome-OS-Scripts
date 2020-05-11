#!/bin/bash
sudo apt-get update
sudo apt-get install curl
sudo service apache2 restart

sudo apt-get install php-curl
sudo service apache2 restart

sudo a2enmod rewrite
sudo service apache2 restart

sudo apt-get install unzip
sudo service apache2 restart
