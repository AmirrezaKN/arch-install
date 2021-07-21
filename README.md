# Arch Basic Install Commands-Script

Modify the packages to your liking, make the script executable with chmod +x scriptname and then run with ./scriptname.
Remember that the first part of the Arch Linux install is manual, that is you will have to partition, format and mount the disk yourself. Install the base packages and make sure to inlcude git so that you can clone the repository in chroot.

A small summary:

1. If needed, load your keymap
2. Refresh the servers with pacman -Syy
3. If the mirrors are too slow try this command: sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist 
4. Partition the disk
5. Format the partitions
6. Mount the partitions
7. Install the base packages into /mnt (pacstrap /mnt base linux linux-firmware git vim intel-ucode (or amd-ucode))
8. Generate the FSTAB file with genfstab -U /mnt >> /mnt/etc/FSTAB
9. Chroot in with arch-chroot /mnt
10. Download the git repository with git clone https://github.com/amirrezaKN/arch-install.git
11. cd arch-install
12. chmod +x install-uefi-virtualbox.sh
13. run with ./install-uefi-virtualbox.sh
