#!/bin/bash

set -eo pipefail

source ./parameters.sh

PWD=$(pwd)
wget $YUM_REPO_URL/cloudera-manager.repo -P /etc/yum.repos.d/

RETURN_VAL=$?

if [[ "${RETURN_VAL}" == 0 ]]; then
    echo "=============================================================================="
    echo "cloudera-manager-repo file downloaded successfully."
else
    echo "----------------------------------------"
    echo "Failed to download the repo file. Please verify the url in parameters.sh file."
    exit 1
fi

wget ${INSTALLER_URL} -P ${PWD}

RETURN_VAL=$?

if [[ "${RETURN_VAL}" == 0 ]]; then
    echo "=============================================================================="
    echo "cloudera-manager-installer file downloaded successfully."
    chmod +x ${PWD}/cloudera-manager-installer.bin
else
    echo "----------------------------------------"
    echo "Failed to download the installer file. Please verify the url in parameters.sh file."
    exit 1
fi
