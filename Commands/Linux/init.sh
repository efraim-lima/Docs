#!/bin/bash 

# Create portmaster data dir 
mkdir -p /opt/safing/portmaster 

#instalando o fdfind
sudo apt install fd-find

# Download portmaster-start utility 
wget -O /tmp/portmaster-start https://updates.safing.io/latest/linux_amd64/start/portmaster-start 
sudo mv /tmp/portmaster-start /opt/safing/portmaster/portmaster-start 
sudo chmod a+x /opt/safing/portmaster/portmaster-start   

# Download resources 
sudo /opt/safing/portmaster/portmaster-start --data /opt/safing/portmaster update 

sudo /opt/safing/portmaster/portmaster-start core 
sudo /opt/safing/portmaster/portmaster-start app 
sudo /opt/safing/portmaster/portmaster-start notifier 

cat << EOF > /etc/systemd/system/portmaster.service 
[Unit] 
Description=Portmaster Privacy App 

[Service] 

Type=simple 
ExecStart=/opt/safing/portmaster/portmaster-start core --data=/opt/safing/portmaster/ 
ExecStopPost=-/sbin/iptables -F C17 
ExecStopPost=-/sbin/iptables -t mangle -F C170 
ExecStopPost=-/sbin/iptables -t mangle -F C171 
ExecStopPost=-/sbin/ip6tables -F C17 
ExecStopPost=-/sbin/ip6tables -t mangle -F C170 
ExecStopPost=-/sbin/ip6tables -t mangle -F C171 

[Install] 

WantedBy=multi-user.target 

EOF 

sudo systemctl daemon-reload 
sudo systemctl enable --now portmaster 
sudo systemctl start portmaster 

#########################################################################################

#setting tmux as terminal 

sudo apt install tmux 

# Clone the Tmux Plugin Manager repository
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cat << EOF > ~/.tmux.conf 
unbind -r
bind -r source-file ~/.tmux.conf

#act like vi
set-option -g mode-keys vi
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

#Alterando configuração para Control A
set-option -g prefix C-a
unbind C-b
bind C-a send-prefix

#Adicionando plugins
set -g @plugin "tmux-plugins/tmux-sensible"
set -g @plugin "tmux-plugins/tpm"
set -g @plugin "tmux-plugins/tmux-yank"
set -g @plugin "tmux-plugins/tmux-resurrect"
set -g @plugin "christoomey/vim-tmux-navigator"
set -g @plugin "tmux-plugins/tmux-battery"
set -g @plugin "olimorris/tmux-pomodoro-plus"
set -g @plugin "3kabhishek/tmux2k"

#tmux ressucection strategy
set -g @ressurect-strategy-vim 'session'
set -g @resurrect-save 'S'
set -g @resurrect-restore 'R'
set -g @continuum-restore 'on'

# set the left and right plugin sections
set -g @tmux2k-theme 'default'
set -g @tmux2k-left-plugins "git cpu ram"
set -g @tmux2k-right-plugins "battery network time"
# to customize plugin colors
#set -g @tmux2k-[plugin-name]-colors "[background] [foreground]"
set -g @tmux2k-cpu-colors "red black" # set cpu plugin bg to red, fg to black
# to enable compact window list size
set -g @tmux2k-compact-windows true
# change refresh rate
set -g @tmux2k-refresh-rate 5
# weather scale
set -g @tmux2k-show-fahrenheit false
# 24 hour time
set -g @tmux2k-military-time true
# network interface to watch
set -g @tmux2k-network-name "wlo1"

run '~/.tmux/plugins/tpm/tpm'

EOF

echo "Inicie o tmux em um novo terminal e insira o comando: 'tmux source ~/.tmux.conf'"

# Wait for user input before continuing
echo "Press Enter to continue..."
read -n 1 -s
echo

echo "Por fim, na sessão instale os plugins: prefix + I"

# Wait for user input before continuing
echo "Press Enter to continue..."
read -n 1 -s
echo

#########################################################################################

sudo update-alternatives --config x-terminal-emulator 

sudo snap install code --classical
sudo snap install docker
#########################################################################################
#OBS 
sudo apt install obs-studio
flatpak install com.obsproject.Studio.Plugin.BackgroundRemoval 
flatpak install flathub com.obsproject.Studio.Plugin.VerticalCanvas 

#########################################################################################
#VIrtualization 
sudo apt install qemu-system 
sudo apt install qemu-user-static 

#virtualox 
sudo apt install virtualbox 
 
#########################################################################################
#Shotcut 
flatpak install flathub org.shotcut.Shotcut 

#########################################################################################
#Torrent client 
sudo apt install transmission 

#########################################################################################
#YouTube Playlist Download
sudo snap install playlist-dl

#########################################################################################
# Clearing cache
# Create the systemd service file 
cat <<EOT > /etc/systemd/system/clear-cache.service 
[Unit] 
Description=Clear system cache 
After=network.target 

[Service] 
Type=oneshot 
ExecStart=/usr/bin/bash -c "sync; echo 3 > /proc/sys/vm/drop_caches" 

[Install] 
WantedBy=multi-user.target 
EOT 

# Enable and start the service 
sudo systemctl daemon-reload 
sudo systemctl enable clear-cache.service 
sudo systemctl start clear-cache.service 

# Create a systemd timer to run the service every 30 minutes 
cat <<EOT > /etc/systemd/system/clear-cache.timer 
[Unit] 
Description=Run clear-cache.service every 30 minutes 

[Timer] 
OnBootSec=30min 
OnUnitActiveSec=30min 
Persistent=True 

[Install] 
WantedBy=timers.target 
EOT 

systemctl daemon-reload 
systemctl enable clear-cache.timer 
systemctl start clear-cache.timer 

#########################################################################################
#e-book reader 
sudo apt install calibre 

#########################################################################################
#install Anti Virus (AV) 
sudo apt install clamav clamav-daemon –y 
clamscan /etc
sudo systemctl enable clamav-daemon  
sudo systemctl start clamav-daemon  

#Edit the ClamAV configuration file with sudo nano /etc/clamav/clamd.conf. Adjust the ScanInterval value for automatic scans 
echo "Edit the ClamAV configuration file with sudo nano /etc/clamav/clamd.conf. Adjust the ScanInterval value for automatic scans" 
sudo systemctl restart clamav-daemon 

#########################################################################################
#Download YouTube videos: 
#youtube-dl --ignore-errors -i -f mp4 --yes-playlist 'https://youtube.com/playlist?list='
#sudo snap install playlist-dl
#for f in *.mkv; do ffmpeg -i "$f" -vn -ab 192k -ar 44100 -y "${f%.*}.mp3"; done

#########################################################################################
#stacer 
sudo add-apt-repository ppa:oguzhaninan/stacer 
sudo apt-get update 
sudo apt-get install stacer 

#########################################################################################
#ncdu  
sudo apt install ncdu 

#########################################################################################
#neofetch 
sudo apt install neofetch 

#########################################################################################
#Usar batcat no lugar do cat:
sudo apt install bat

#########################################################################################
#Baixar o Net Tools e outras ferramentas de IP
sudo apt install net-tools
sudo apt install nmap -y
sudo apt install whois

#########################################################################################
#Ferramenta de auditoria do sistema
sudo apt install auditd -y

#########################################################################################
sudo add-apt-repository ppa:gns3/ppa
sudo apt update                                
sudo apt install gns3-gui gns3-server -y
sudo apt install python3 python3-pip pipx python3-pyqt5 python3-pyqt5.qtwebsockets python3-pyqt5.qtsvg qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst dynamips software-properties-common ca-certificates curl gnupg2 
pipx inject gns3-gui gns3-server PyQt5
# launch with gns3 command
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install gns3-iou
sudo apt install sysstat

#########################################################################################
#Prometheus e Grafana 
#Plex e Jellyfin => servidores de midia 
#Pi-hole e Wireguard => bloqueadores de anuncios e DNS service 
#Pritunl ou OpenVPN => servicos de VPN 
#Nextcloud => cloud storage 

#Reboot
sudo reboot
