#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Catch errors in pipes

echo "Updating system and installing dependencies..."
sudo yum install -y git dnf wget telnet net-tools bind-utils iproute traceroute nc python3 python3-pip ansible-core

echo "Verifying installations..."
git --version
python3 --version
pip3 --version
ansible --version

echo "Cloning the repository..."
git clone https://github.com/kuldeepsahu1105/pvc-automation.git
cd pvc-automation/ansible-test/

echo "Pulling latest changes..."
git pull

echo "Setting permissions for SSH key..."
chmod 600 kuldeep-pvc-session.pem
ls -al kuldeep-pvc-session.pem

echo "Installing Python dependencies..."
pip3 install psycopg2-binary

echo "Running Ansible playbooks..."
ansible-playbook 0_set_hostname.yml -i inv.ini
ansible-playbook 1_create_etc_hosts.yml -i inv.ini
cat /etc/hosts
ansible-playbook 2_setup_autossh.yml -i inv.ini

echo "Installing IPA Server and required packages..."
sudo dnf install -y ipa-server bind bind-dyndb-ldap ipa-server-dns firewalld

echo "Script execution completed!"
