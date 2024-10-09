#!/bin/bash

echo Creating To Transfer 
mkdir -p ./tot/

echo Listing all installed DNF Packages
sudo dnf update -y
dnf list installed > ./tot/installed-packages.txt

echo Listing Flatpack Apps
flatpak list > ./tot/flatpak-apps.txt

echo installing Curl
sudo dnf install curl

sudo mkdir -p ./tot/jetbrains-backups
sudo cp -r ~/.config/JetBrains/* ./tot/jetbrains-backups/

sleep 2

cp ./install_all_back.sh ./tot/install_all_back.sh
