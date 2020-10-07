sudo add-apt-repository "deb http://ftp.de.debian.org/debian buster main contrib"
sudo apt update && sudo apt upgrade -y
sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install wine -y
sudo apt install wine32 -y
sudo apt-get install libgl1-mesa-glx:i386 libgl1-mesa-dri:i386 -y
sudo apt update -y
sudo apt install netcat -y
sudo apt install gettext -y
sudo apt-get install playonlinux -y
