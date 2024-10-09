#!/bin/bash
echo Updating DNF
sudo dnf update -y

echo Installing all Packages back
awk '{print $1}' installed-packages.txt > package-list.txt
sudo dnf install -y $(cat package-list.txt)

echo Installing Flastpak Apps
awk '{print $1}' flatpak-apps.txt > flatpak-app-list.txt
xargs -a flatpak-app-list.txt -I{} flatpak install -y flathub {}

echo Installing Curl
sudo dnf install curl -y

echo Installing Jetbrains Toolbox
curl https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.4.2.32922.tar.gz

cp -r ./jetbrains-backups/* ~/.config/JetBrains/

