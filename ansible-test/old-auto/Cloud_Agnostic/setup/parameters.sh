#!/bin/bash

WORKDIR="/tmp/CDP_PvC/Cloudera_Partner_CDP_PvC_Setup/Cloud_Agnostic/setup/playbooks"
USERNAME="cdpuser"
PASSWORD="cloudera@123"

### Update this section with the Private IPs of the hosts
CDP_MASTER=
CDP_BASE_WORKER1=
CDP_BASE_WORKER2=
CDP_BASE_WORKER3=
FREEIPA_SERVER=

### CDP Base License Credentials ###
CDP_LICENSE_USERNAME=
CDP_LICENSE_PASSWORD=
PARENT_URL=https://${CDP_LICENSE_USERNAME}:${CDP_LICENSE_PASSWORD}@archive.cloudera.com/p/cm7/7.9.5
YUM_REPO_URL=${PARENT_URL}/redhat7/yum/
INSTALLER_URL=${PARENT_URL}/cloudera-manager-installer.bin
