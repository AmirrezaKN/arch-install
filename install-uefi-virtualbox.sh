#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

hwclock --systohc

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:1 | chpasswd

sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

pacman -S --noconfirm rsync reflector

reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

pacman -S --noconfirm sudo vim man-db rofi alacritty pcmanfm-gtk3 man-pages texinfo go xorg xorg-xinit i3 feh picom firefox grub efibootmgr networkmanager dosfstools base-devel linux-headers bash-completion os-prober ntfs-3g virtualbox virtualbox-guest-utils virtualbox-host-modules-arch

mkdir -p /home/amir

mkdir -p /home/amir/Downloads
git -C /home/amir/Downloads clone https://aur.archlinux.org/yay.git

mkdir -p /home/amir/Documents/github.com/AmirrezaKN
git -C /home/amir/Documents/github.com/AmirrezaKN clone https://github.com/AmirrezaKN/dotfiles.git

head -n -5 /etc/X11/xinit/xinitrc > /home/amir/.xinitrc
echo 'VBoxClient --vmsvga' >> /home/amir/.xinitrc
echo 'VBoxClient-all' >> /home/amir/.xinitrc
echo 'exec i3' >> /home/amir/.xinitrc

cp -r /home/amir/Documents/github.com/AmirrezaKN/dotfiles/.bash_profile /home/amir/Documents/github.com/AmirrezaKN/dotfiles/.zprofile /home/amir/Documents/github.com/AmirrezaKN/dotfiles/.vimrc /home/amir/Documents/github.com/AmirrezaKN/dotfiles/.vim /home/amir
mkdir -p /home/amir/.config
cp -r /home/amir/Documents/github.com/AmirrezaKN/dotfiles/alacritty /home/amir/Documents/github.com/AmirrezaKN/dotfiles/i3 /home/amir/Documents/github.com/AmirrezaKN/dotfiles/polybar /home/amir/Documents/github.com/AmirrezaKN/dotfiles/gtk-3.0 /home/amir/.config
cp -r /home/amir/Documents/github.com/AmirrezaKN/fonts /usr/share/
chmod +x /home/amir/.config/polybar/launch.sh

mkdir -p /home/amir/Pictures
cp -r /home/amir/Documents/github.com/AmirrezaKN/dotfiles/wallpaper /home/amir/Pictures

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable reflector.timer
systemctl enable NetworkManager
systemctl enable vboxservice

useradd -m amir
echo amir:1 | chpasswd
usermod -aG wheel amir
sed -i 's/\# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
chown -R amir /home/amir

printf "\e[1;32mDone! Now install yay, polybar, zsh, ohmyzsh and powerlevel10k.\n\e[0m"
