#!/bin/bash

# Ensure packages are up-to-date
sudo apt update && sudo apt-upgrade

# GH cli
# sudo dnf install dnf5-plugins
# sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
# sudo dnf install gh --repo gh-cli

# Essentials
# sudo flatpak install syncthingy
# sudo flatpak install librewolf
# sudo flatpak install app.zen_browser.zen
# sudo flatpak install com.vscodium.codium-insiders

## Mullvad VPN
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc

echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list

sudo apt update && sudo apt install mullvad-vpn

# Entertainment
# sudo flatpak install spotify
# sudo flatpak install freetube

# Social
wget https://vencord.dev/download/vesktop/amd64/deb && sudo dpkg -i vesktop_numbers_amd64.deb # replace with actual version num

## Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list

sudo apt update && sudo apt install signal-desktop


