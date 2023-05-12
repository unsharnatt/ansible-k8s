#!/bin/bash

# Enable ssh password authentication
echo "Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "Set root password"
echo "admin" | passwd --stdin root >/dev/null 2>&1

# Set local user account TODO *****
echo "Set up local user account"
#useradd -m -s /bin/bash vagrant
#echo "vagrant" | passwd --stdin vagrant >/dev/null 2>&1
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Update bashrc file
# echo "export TERM=xterm" >> /etc/bashrc

# --- ***end user preparation*** ---

# Install kubesphere pre-requisites
echo "Install socat & conntrack"
yum update -y >/dev/null 2>&1
yum install -y socat conntrack >/dev/null 2>&1

# Configure persistent loading of modules
tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

# Load at runtime
modprobe overlay
modprobe br_netfilter

# Ensure sysctl params are set
tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload configs
sysctl --system

# Install required packages
yum install -y yum-utils device-mapper-persistent-data lvm2 >/dev/null 2>&1

# Add Docker repo
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install containerd
yum update -y && yum install -y containerd.io >/dev/null 2>&1

# Configure containerd and start service
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml

# restart containerd
systemctl restart containerd
systemctl enable containerd

# Stop and disable firewalld
#echo "[TASK 5] Stop and Disable firewalld"
#systemctl disable firewalld --now >/dev/null 2>&1

