#!/bin/bash

set -e

# This script can be used to build the VM if the base eMoflon::IBeX box is 
# already available on the host system.

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
