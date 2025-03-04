#!/bin/bash

CDP_LICENSE_USERNAME=""
CDP_LICENSE_PASSWORD=""

yum install -y httpd
systemctl start httpd
systemctl enable httpd

mkdir -p /var/www/html/cdp-pvc-ds

echo "Starting the ECS bits download"

wget -l 0 --recursive -no-parent -e robots=off -nH --cut-dirs=2 --reject="index.html*" -t 10 https://${CDP_LICENSE_USERNAME}:${CDP_LICENSE_PASSWORD}@archive.cloudera.com/p/cdp-pvc-ds/latest/ -P /var/www/html/cdp-pvc-ds/

RETURN_VAL=$?

echo "--------------------------------------------------------"

if [[ "${RETURN_VAL}" == 0 ]]; then
    echo "Successfully downloaded."
else
    echo "Download not successful."
fi


## Command to run this script ##
# nohup sh ecs_bits_download.sh > ecs_download.log &
