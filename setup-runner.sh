#!/bin/bash

set -e

# Displays the given input including "=> " on the console.
log () {
	echo "=> $1"
}

# Check if required tools are installed
log "Checking required tools."
apt-get update
apt-get install -yq tmux htop iotop iftop ncdu

# wget
if ! command -v wget &> /dev/null
then
    log "Binary wget could not be found. Installing it."
    apt-get install -yq wget
fi

# unzip
if ! command -v unzip &> /dev/null
then
    log "Binary unzip could not be found. Installing it."
    apt-get install -yq unzip
fi

# tar
if ! command -v tar &> /dev/null
then
    log "Binary tar could not be found. Installing it."
    apt-get install -yq tar
fi

# sed
if ! command -v sed &> /dev/null
then
    log "Binary sed could not be found. Installing it."
    apt-get install -yq sed
fi

# VirtualBox
if ! command -v vboxmanage &> /dev/null
then
    log "Binary vboxmanage could not be found. Installing it."
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
    log "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bullseye contrib" | tee /etc/apt/sources.list.d/virtualbox.list
    apt-get update
    apt-get install -yq virtualbox-7.0
fi

# Vagrant
if ! command -v vagrant &> /dev/null
then
    log "Binary vagrant could not be found. Installing it."
    apt-get install -yq apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    apt-get update
    apt-get install -yq vagrant
fi

log "Finished successfully."
