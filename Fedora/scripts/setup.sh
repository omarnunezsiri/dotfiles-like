#!/bin/bash

# Ensure packages are up-to-date
sudo dnf update
sudo flatpak update

# DNS Config
echo "DNS Config #DNS=194.242.2.6#family.dns.mullvad.net
DNSSEC=no
DNSOverTLS=yes
Domains=~."
sudo systemctl enable systemd-resolved
sudo nano /usr/lib/systemd/resolved.conf 
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl restart systemd-resolved
sudo systemctl restart NetworkManager
resolvectl status

# Install tray icons extension
sudo dnf install libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app

# GH cli
sudo dnf install dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli

# Essentials
sudo flatpak install syncthingy
sudo flatpak install librewolf

## Proton VPN
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.2-1.noarch.rpm"
sudo dnf install ./protonvpn-stable-release-1.0.2-1.noarch.rpm && sudo dnf check-update --refresh 
sudo dnf install proton-vpn-gnome-desktop 
# GPG key 0xF43719CA: Userid : “Proton Technologies AG <opensource@proton.me>” Fingerprint: 9E72 DFDF 2AF0 19F0 CCFC 68F3 8DD4 8989 F437 19CA
# GPG key 0x67FCBBBB:: Userid : “Proton Technologies AG <opensource@proton.me>” Fingerprint: F200 18AD 1914 638B C3B4 85F7 413E 4BA3 67FC BBBB


## VBox
sudo dnf config-manager addrepo --from-repofile=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf update
sudo dnf install VirtualBox-7.1

# Entertainment
sudo flatpak install spotify
sudo flatpak install freetube

# Social
sudo flatpak install dev.vencord.Vesktop
sudo flatpak install org.signal.Signal


