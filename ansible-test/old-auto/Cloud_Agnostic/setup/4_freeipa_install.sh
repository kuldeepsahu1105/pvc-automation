#!/bin/bash

set -eo pipefail

source ./parameters.sh

ansible-playbook -i /tmp/CDP_PvC/ansible/hosts $WORKDIR/freeipa_setup.yaml

echo "FreeIPA packages installation is completed."
