#!/bin/bash

echo "Creating Transfer Directory"
mkdir -p "./tot/"

echo "Listing all installed DNF Packages"
sudo dnf update -y
dnf list installed > "./tot/installed-packages.txt"

echo "Listing Flatpak Apps"
flatpak list > "./tot/flatpak-apps.txt"

echo "Installing Curl"
sudo dnf install -y curl

echo "Saving JetBrains Config"
sudo mkdir -p "./tot/jetbrains-backups"
sudo cp -r ~/.config/JetBrains/* "./tot/jetbrains-backups/" || {
    echo "Failed to copy JetBrains configuration. Adjust permissions if needed."
    exit 1
}

echo "Setting permissions for JetBrains backups"
sudo chown -R $USER:$USER ./tot/jetbrains-backups

echo "Saving Settings"
dconf dump / > "./tot/system-settings.dconf"

echo "Saving System Folders"
mkdir -p "./tot/backup-system-configs"
cp -r ~/.config "./tot/backup-system-configs/" || {
    echo "Failed to copy config directory."
    exit 1
}

cp -r ~/.local/bin "./tot/backup-system-configs/" || {
    echo "Failed to copy local bin directory."
    exit 1
}
cp -r ~/.local/include "./tot/backup-system-configs/" || {
    echo "Failed to copy local include directory."
    exit 1
}
cp -r ~/.local/lib "./tot/backup-system-configs/" || {
    echo "Failed to copy local lib directory."
    exit 1
}
cp -r ~/.local/state "./tot/backup-system-configs/" || {
    echo "Failed to copy local state directory."
    exit 1
}

# Remove specific directories if they exist
rm -rf "./tot/backup-system-configs/.config/libvirt"
rm -rf "./tot/backup-system-configs/.config/figma-linux"

# Warning: Uncomment this line if your cloud storage is bigger than 100 GB
# cp -r ~/.local/share "./tot/backup-system-configs/"

cp -r ~/.themes "./tot/backup-system-configs/" || {
    echo "Failed to copy themes directory."
}
cp -r ~/.icons "./tot/backup-system-configs/" || {
    echo "Failed to copy icons directory."
}

sleep 2

echo "Copying install_all_back.sh"
cp ./install_all_back.sh "./tot/install_all_back.sh" || {
    echo "Failed to copy install_all_back.sh"
    exit 1
}

chmod -R 777 tot

read -p "Do you want to autozip tot (To Transfer Folder)? (y/N): " response

if [[ "$response" =~ ^[Yy]$ ]]; then
    zip -r tot_archived.zip tot 
    chmod 666 tot_archived.zip
    # sudo chown -R $USER:$USER ./tot_archived.zip
fi

echo "Backup process completed."

