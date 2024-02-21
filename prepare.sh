#!/bin/bash

set -e

# Check if emoflon.box was already created
if [[ -f "./emoflon.box" ]]; then
	echo "emoflon.box was already created, skipping preparation."
	exit 0
fi

# concatenate ZIP archive
cat *-vm.z* > cat.zip

# unzip it
unzip cat.zip || :
rm -rf cat.zip

# Import OVA in VirtualBox
vboxmanage import ./emoflon-ova/emoflon.ova --vsys 0 --eula accept
rm -rf ./emoflon-ova

# Get VM ID
raw_id=$(vboxmanage list vms)
id=$(echo $raw_id | awk -F[{}] '{print $2}')

# Package the VM as Vagrant box
vagrant package --base $id --output emoflon.box

# Add box as local Vagrant box
vagrant box add emoflon.box --name emoflon
