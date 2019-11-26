Sudo apt-get install git -y
git config --global credential.helper store
read -p "Enter Your UserName for Github: "  username
git config --global user.name $username
echo "Usename Stored: " $username
read -p "Enter Your Email for Github: " email
git config --global user.email $email
echo "Email Stored: " $email
read -p "Enter Your Password for Github: " password
git config --global user.password $password
echo "Password Stored: " $password