#!/usr/bin/env bash

set -euxo pipefail

source /provisioning/config

echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
mkinitcpio -p linux

CMDLINE='console=tty0 console=ttyS0,115200n8'
grub-install --target=i386-pc "${DEVICE}"
sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT\)=.*/\1=""/' /etc/default/grub
sed -i "s/\(GRUB_CMDLINE_LINUX\)=.*/\1=\"${CMDLINE}\"/" /etc/default/grub
echo 'GRUB_TERMINAL=serial' >> /etc/default/grub
echo 'GRUB_SERIAL_COMMAND="serial --speed=115200"' >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

cp /provisioning/files/cloud.cfg /etc/cloud/
systemctl enable cloud-init-local cloud-init cloud-config cloud-final

cp /provisioning/files/ethernet.network /etc/systemd/network/
systemctl enable systemd-networkd

sed -i 's/^hosts:.*/hosts: files resolve myhostname/' /etc/nsswitch.conf
rm -f /etc/resolv.conf
ln -s /usr/lib/systemd/resolv.conf /etc/resolv.conf
systemctl enable systemd-resolved

systemctl enable sshd
