#!/bin/bash
# Ask the user for login details

Sudo apt-get install git -y
git config --global credential.helper store
echo "Enter Your UserName for Github: "
read -p username
git config --global user.name $username
echo "Usename Stored: " $username
echo "Enter Your Email for Github: "
read -p email
git config --global user.email $email
echo "Email Stored: " $email
echo "Enter Your Password for Github: "
read -sp password
git config --global user.password $password
echo "Password Stored: " $password
