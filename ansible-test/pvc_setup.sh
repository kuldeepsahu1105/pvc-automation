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

# Check if the directory exists before cloning
if [ ! -d "pvc-automation" ]; then
    echo "Cloning the repository..."
    git clone https://github.com/kuldeepsahu1105/pvc-automation.git
else
    echo "Repository already exists. Skipping cloning."
fi

cd pvc-automation/ansible-test/

echo "Pulling latest changes..."
git pull

echo "Setting permissions for SSH key..."
chmod 600 kuldeep-pvc-session.pem
ls -al kuldeep-pvc-session.pem

echo "Installing Python dependencies..."
pip3 install psycopg2-binary

echo "Running Ansible playbooks..."

echo "Installing collection dependencies..."
ansible-playbook -i inventory.ini 0_install_collection.yml

echo "Setting hostname..."
ansible-playbook -i inventory.ini 1_set_hostname.yml

echo "Creating /etc/hosts entries..."
ansible-playbook -i inventory.ini 2_create_etc_hosts.yml
cat /etc/hosts

echo "Setting up autossh..."
ansible-playbook -i inventory.ini 3_setup_autossh.yml

echo "Disabling SELinux..."
ansible-playbook -i inventory.ini 4_disable_selinux.yml

echo "Running prerequisite setup..."
ansible-playbook -i inventory.ini 5_prereq_setup.yml

echo "Running additional prerequisite setup..."
ansible-playbook -i inventory.ini 6_prereq_setup_002.yml

echo "Setting up FreeIPA server..."
ansible-playbook -i inventory.ini 7_setup_freeipa_server.yml

echo "Configuring DNS records..."
ansible-playbook -i inventory.ini 8_setup_dns_records.yml

echo "Setting up node prerequisites..."
ansible-playbook -i inventory.ini 9_node_prereqs_setup.yml

echo "Setting up FreeIPA client..."
ansible-playbook -i inventory.ini 10_setup_freeipa_client.yml

echo "Setting up wildcard certificates..."
ansible-playbook -i inventory.ini 11_setup_wildcard.yml

echo "Script execution completed!"
