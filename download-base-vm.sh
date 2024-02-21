#!/bin/bash


#
# Config
#

EMOFLON_BASE_VM_RELEASE=v1.0.0.202312051648-r2

set -e
START_PWD=$PWD

# Displays the given input including "=> " on the console.
log () {
	echo "=> $1"
}

if [[ ! -f "./emoflon-vm.zip" ]]; then
	log "Downloading eMoflon::IBeX VM archive: $EMOFLON_BASE_VM_RELEASE"
	wget -q https://github.com/eMoflon/emoflon-ibex-vm/releases/download/$EMOFLON_BASE_VM_RELEASE/emoflon-vm.zip
	wget -q https://github.com/eMoflon/emoflon-ibex-vm/releases/download/$EMOFLON_BASE_VM_RELEASE/emoflon-vm.z01
	wget -q https://github.com/eMoflon/emoflon-ibex-vm/releases/download/$EMOFLON_BASE_VM_RELEASE/emoflon-vm.z02
fi
