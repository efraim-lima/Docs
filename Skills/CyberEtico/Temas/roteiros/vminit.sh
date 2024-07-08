#Primeiro processo para configuração de maquinas virtuais pequenas é abrir um terminal e inserir:

sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom/
cd /media/cdrom/
sudo -s
./autorun.sh
reboot

# Após feito isso precisamos instalar o irtualBox Guest Additions x64 localizado no outro host
