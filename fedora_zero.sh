#!/bin/bash

# Добавление репозиториев:
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#Установка нужного софта:
flatpak install --noninteractive -y flathub com.google.Chrome

# Установка Телеграма
flatpak install --noninteractive -y flathub org.telegram.desktop

# Удаление офисного пакета
if rpm -q libreoffice 1>/dev/null; then
    read -p "Локально установлен LibreOffice. Удалить его со всеми зависимостями? (y/n) " uninstall
    if [ "$uninstall" == "y" ]; then
        sudo dnf remove libreoffice*
    fi
fi

# Установка торрент-клиента
flatpak install --noninteractive -y flathub org.qbittorrent.qBittorrent

# Установка набора для Игр
sudo dnf install steam wine-core mangohud gamemode goverlay -y && flatpak install --noninteractive -y com.vysp3r.ProtonPlus

# Установка всякой всячины
sudo dnf install papirus-icon-theme

wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C adwaita --theme Papirus-Dark

sudo dnf install gnome-tweaks && flatpak install --noninteractive -y flathub com.github.tchx84.Flatseal com.mattjakeman.ExtensionManager

dnf install ffmpeg-free gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y

#Очистка системы:
sudo dnf autoremove
sudo dnf clean all
flatpak uninstall --unused -y

read -p ">>> Мы закончили " choice
exit
