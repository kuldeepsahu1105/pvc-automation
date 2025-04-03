#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Catch errors in pipes

# Function to print a fancy banner
print_message() {
    echo ""
    echo "================================================================="
    echo "            🚀 $(echo $0) 🚀          "
    echo "================================================================="
    echo ""
}

# Uncomment this section if repository cloning is required
print_message "Checking and setting up repository..."
if [ -d "pvc-automation" ]; then
    echo "Repository already exists. Pulling latest changes..."
    cd pvc-automation
    # git reset --hard
    # git clean -fd
    git pull origin main
else
    echo "Cloning the repository..."
    git clone https://github.com/kuldeepsahu1105/pvc-automation.git
    cd pvc-automation
fi

# Navigate to ansible-test directory if it exists
if [ -d "ansible-test" ]; then
    cd ansible-test
    
# Check for pem/idrsa file in the current path
pem_file=$(find . -maxdepth 1 -type f \( -name "*.pem" -o -name "idrsa" \))
if [ -z "$pem_file" ]; then
    echo "Error: No .pem or idrsa file found in the current directory."
    exit 1
else
    echo "Found key file: $pem_file"
    sed -i.bak "s|private_key_file:.*|private_key_file: $pem_file|" group_vars/all.yml
    echo "Updated group_vars/all.yml with the key file name."
fi

# Check for a txt file with "license" in its name and rename it to license.txt
license_file=$(find . -maxdepth 1 -type f -name "*license*.txt")
if [ -z "$license_file" ]; then
    echo "Error: No license file found in the current directory."
    exit 1
else
    mv "$license_file" license.txt
    echo "Renamed $license_file to license.txt"
fi
fi

# Execute pvc_setup.sh
print_message "Executing pvc_setup.sh..."
chmod +x pvc_setup.sh
./pvc_setup.sh
