#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Catch errors in pipes

# Function to print a fancy banner
print_banner() {
    echo "================================================================="
    echo "            🚀 CLOUDERA ON-PREMISE INSTALLATION SETUP 🚀          "
    echo "================================================================="
    echo ""
}

# Function to print completion message
print_completion() {
    echo ""
    echo "================================================================="
    echo " ✅ CLOUDERA INSTALLATION SETUP COMPLETED SUCCESSFULLY! 🎉       "
    echo "================================================================="
}

# Function to print a fancy banner
print_message() {
    echo ""
    echo "================================================================="
    echo "            🚀 $(echo $1) 🚀          "
    echo "================================================================="
    echo ""
}

# Print welcome banner
print_banner

echo "Updating system and installing dependencies..."
sudo yum install -y git dnf wget telnet net-tools bind-utils dnsutils iproute traceroute nc python3 python3-pip ansible-core

echo "Verifying installations..."
git --version
python3 --version
pip3 --version
ansible --version

# # Clone or update repository
# if [ -d "pvc-automation" ]; then
#     echo "Repository already exists. Pulling latest changes..."
#     cd pvc-automation
#     git reset --hard
#     git clean -fd
#     git pull origin main
# else
#     echo "Cloning the repository..."
#     git clone https://github.com/kuldeepsahu1105/pvc-automation.git
#     cd pvc-automation
# fi

# cd ansible-test/

# Find private key file
PRIVATE_KEY=$(find . -maxdepth 1 -type f \( -name "*.pem" -o -name "id_rsa" \) | head -n 1)

if [[ -z "$PRIVATE_KEY" ]]; then
    echo "No private key found in the current directory. Checking ~/.ssh..."
    if [[ -f "$HOME/.ssh/id_rsa" ]]; then
        PRIVATE_KEY="$HOME/.ssh/id_rsa"
        echo "Using existing key from ~/.ssh/id_rsa"
    else
        echo "No key found in ~/.ssh. Generating a new SSH key..."
        ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa" -N ""
        PRIVATE_KEY="$HOME/.ssh/id_rsa"
        echo "Generated new SSH key: $PRIVATE_KEY"
    fi
fi

echo "Using private key: $PRIVATE_KEY"
chmod 600 "$PRIVATE_KEY"
ls -al "$PRIVATE_KEY"

# Update ansible_ssh_private_key_file in group_vars/all.yml
echo "Updating ansible_ssh_private_key_file in group_vars/all.yml..."
sed -i "/^ansible_ssh_private_key_file:/c\ansible_ssh_private_key_file: $PRIVATE_KEY" group_vars/all.yml

# Ensure SSH allows password authentication and root login
echo "Updating SSH configuration on IPAServer..."
sudo sed -i 's/^#*PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Updating SSH configuration prerequisites on all other hosts..."
# ansible all -i inventory.ini -m lineinfile -a "path=/etc/ssh/sshd_config regexp='^#*PasswordAuthentication' line='PasswordAuthentication yes'" --become
# ansible all -i inventory.ini -m lineinfile -a "path=/etc/ssh/sshd_config regexp='^#*PermitRootLogin' line='PermitRootLogin yes'" --become
# ansible all -i inventory.ini -m service -a "name=sshd state=restarted" --become
ansible-playbook -i inventory.ini 0_setup_ssh_preqs.yml --limit 'all:!ipaserver' --private-key="$PRIVATE_KEY"

# Function to print playbook execution message
run_playbook() {
    local playbook_name="$1"
    echo ""
    echo "------------------------------------------------------"
    echo "▶ Running playbook: $playbook_name"
    echo "------------------------------------------------------"
    ansible-playbook -i inventory.ini "$playbook_name"
}

# # Run all numbered playbooks in order
# for playbook in $(ls -1 *.yml | grep -E '^[0-9]+' | sort -V); do
#     echo "------------------------------------------------------"
#     echo "▶ Running playbook: $playbook"
#     echo "------------------------------------------------------"
#     ansible-playbook -i inventory.ini "$playbook"
# done

print_message "Running Ansible playbooks..."

print_message "Installing collection dependencies..."
run_playbook "1_install_collection.yml"

print_message "Setting hostname..."
run_playbook "2_set_hostname.yml"

print_message "Creating /etc/hosts entries..."
run_playbook "3_create_etc_hosts.yml"
cat /etc/hosts

print_message "Setting up autossh..."
run_playbook "4_setup_autossh.yml"

print_message "Disabling SELinux..."
run_playbook "5_disable_selinux.yml"

print_message "Running prerequisite setup..."
run_playbook "6_prereq_setup.yml"

print_message "Running additional prerequisite setup..."
run_playbook "7_prereq_setup_002.yml"

print_message "Running more prerequisite setup..."
run_playbook "8_prereq_setup_003.yml"

print_message "Verifying OS Prereqs..."
run_playbook "9_verify_os_prereqs.yml"

print_message "Setting up FreeIPA server..."
run_playbook "10_setup_freeipa_server.yml"

print_message "Configuring DNS records..."
run_playbook "11_setup_dns_records.yml"

print_message "Setting up /etc/resolv.conf file..."
run_playbook "12_update_resolv_conf.yml"

print_message "Setting up /etc/sysconfig/network file..."
run_playbook "13_update_syscfg_network.yml"

print_message "Setting up FreeIPA client..."
run_playbook "14_setup_freeipa_client.yml"

print_message "Setting up wildcard DNS Record..."
run_playbook "15_setup_wildcard.yml"

print_message "Setting up internal repository..."
run_playbook "16_setup_internal_repo.yml"

print_message "Downloading CM, CDH and Spark repository files..."
run_playbook "17_download_repos.yml"

print_message "Setting up postgres db..."
run_playbook "18_setup_postgres.yml"

print_message "Setting up (installing) CM server..."
run_playbook "19_start_cm.yml"
# Print completion banner
print_completion
