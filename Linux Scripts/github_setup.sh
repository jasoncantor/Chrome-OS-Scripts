#!/bin/bash
# Ask the user for login details

Sudo apt-get install git -y
git config --global credential.helper store
echo "Enter Your UserName for Github: "
read username
git config --global user.name $username
echo "Usename Stored: " $username
echo "Enter Your Email for Github: "
read email
git config --global user.email $email
echo "Email Stored: " $email
echo "Enter Your Password for Github: "
read password
git config --global user.password $password
echo "Password Stored: " $password
