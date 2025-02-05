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

# GH cli
sudo dnf install dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli

# Essentials
sudo flatpak install syncthingy
sudo flatpak install librewolf
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


