#!/bin/bash

set -eo pipefail

IPA_ADMIN_PASSWORD=cdp@123456
DIRECTORY_MANAGER_PASSWORD=cdp@123456

install_freeipa() {

    ipa-server-install --setup-dns --hostname=ipaserver.cdppvcpoc.com -r CDPPVCPOC.COM -n cdppvcpoc.com -a "$IPA_ADMIN_PASSWORD" -p "$DIRECTORY_MANAGER_PASSWORD" --no-forwarders --forward-policy=only -U

}

uninstall_freeipa() {
    ipa-server-install --uninstall -U
}


install_freeipa
RETURN_VAL=$?

if [[ "${RETURN_VAL}" == 0 ]]; then
    echo "=============================================================================="
    echo "FreeIPA installation is successful."
else
    echo "----------------------------------------"
    echo "FreeIPA installation failed. Debug the issue by logging into the freeipa node."
    echo "----------------------------------------"
    echo "Check the error log for the installation in this file:- /var/log/ipaserver-install.log"
    uninstall_freeipa
    exit 1
fi
