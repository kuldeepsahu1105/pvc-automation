#!/bin/bash
set -eo pipefail

source ./parameters.sh

update_sshd_config() {
    cp /etc/ssh/sshd_config /tmp/CDP_PvC/sshd_config_backup
    sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
    systemctl restart sshd
    systemctl status sshd
    RETURN_VAL=$?
    if [[ "${RETURN_VAL}" == 0 ]]; then
        echo "----------------------------------------"
        echo "sshd restart successful"
    else
        echo "----------------------------------------"
        echo "Seems like there is an issue with sshd. Check the sshd config again."
        echo "The original sshd_config file is present here: /tmp/CDP_PvC/sshd_config_backup"
    fi
}

### Before adding the user check if the user exists
if id -u "$USERNAME" >/dev/null 2>&1; then
  echo "The user $USERNAME exists."
else
  echo "The user $USERNAME not exist. "
  echo "Creating a user for running ansible playbooks"
  useradd --create-home --shell /bin/bash $USERNAME
  echo -e "$PASSWORD\n$PASSWORD" | passwd $USERNAME
  usermod -aG wheel $USERNAME
  fi

echo "Updating the sshd_config to allow password authentication"
update_sshd_config
