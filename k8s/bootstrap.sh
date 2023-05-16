#!/bin/bash

# Enable ssh password authentication
echo "Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "Set root password"
echo "admin" | passwd --stdin root >/dev/null 2>&1

# Set local user account ***TODO if specific user needed***
echo "Set up local user account"
#useradd -m -s /bin/bash vagrant
#echo "vagrant" | passwd --stdin vagrant >/dev/null 2>&1
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Update bashrc file
# echo "export TERM=xterm" >> /etc/bashrc

# --- ***end user preparation*** ---
