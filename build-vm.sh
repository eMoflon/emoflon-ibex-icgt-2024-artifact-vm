#!/bin/bash

set -e

is_installed() {
    if ! command -v $1 &> /dev/null
    then
        echo "Binary $1 could not be found."
        exit
    fi
}

# Check if required tools are installed
echo "Checking required tools."
is_installed wget
is_installed unzip
is_installed tar
is_installed sed
is_installed vboxmanage
is_installed vagrant

# Run other scripts
echo "Starting download script."
./download-base-vm.sh
echo "Starting vagrant box preparation script."
./prepare.sh

echo "Start vagrant provisioning."
vagrant up
vagrant halt
vboxmanage export emoflon-icgt -o emoflon.ovf

# Apply "fix" for missing nvram file + remote display
sed -i -e '/<BIOS>/,/<\/BIOS>/d' emoflon.ovf
sed -i -e '/<RemoteDisplay enabled="true">/,/<\/RemoteDisplay>/d' emoflon.ovf

# Pack OVA from modified files
tar -cvf emoflon.ova emoflon.ovf emoflon-disk001.vmdk
rm -rf emoflon.ovf emoflon-disk001.vmdk

echo "eMoflon OVA was exported successfully."
