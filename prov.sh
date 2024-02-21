#!/bin/bash

#
# Config
#

ECLIPSE_ARCHIVE=eclipse-emoflon-linux-dev-hipe
EMOFLON_RELEASE=v1.0.0.202312051648
EMOFLON_SRC_URL="https://github.com/eMoflon/emoflon-ibex-eclipse-build/releases/download/$EMOFLON_RELEASE/$ECLIPSE_ARCHIVE.zip"

set -e
START_PWD=$PWD

#
# Utils
#

# Displays the given input including "=> " on the console.
log () {
	echo "=> $1"
}

#
# Script
#

log "Start provisioning."

# Remove pre-installed IBeX Eclipse because we need to build our own version
rm -rf ~/eclipse-apps

# Custom IBeX Eclipse
log "Installing custom eMoflon::IBeX Eclipse."
mkdir -p ~/eclipse-apps
cd ~/eclipse-apps

# Get the base Eclipse
if [[ ! -f "./$ECLIPSE_ARCHIVE.zip" ]]; then
	log "Downloading specified eMoflon::IBeX Eclipse archive from Github."
        wget -q $EMOFLON_SRC_URL
fi

if [[ ! -f "./$ECLIPSE_ARCHIVE.zip" ]]; then
        log "Download of eMoflon::IBeX Eclipse archive failed."
        exit 1;
fi

unzip -qq -o $ECLIPSE_ARCHIVE.zip
rm -f $ECLIPSE_ARCHIVE.zip

# Install HiPE from custom updatesite to included Eclipse (VM)
cd /home/vagrant
unzip updatesite-hipe.zip -d /home/vagrant/updatesite-hipe
cd /home/vagrant/eclipse-apps/eclipse
./eclipse -noSplash -consoleLog -application org.eclipse.equinox.p2.director -repository file:///home/vagrant/updatesite-hipe/ -installIU hipe.feature.feature.group

# Install eMoflon::IBeX from custom updatesite to included Eclipse (VM)
cd /home/vagrant
unzip updatesite-emoflon.zip -d /home/vagrant/updatesite-emoflon
cd /home/vagrant/eclipse-apps/eclipse
./eclipse -noSplash -consoleLog -application org.eclipse.equinox.p2.director -repository file:///home/vagrant/updatesite-emoflon/ -installIU org.emoflon.ibex.ide.hipe.feature.feature.group,org.emoflon.ibex.ide.feature.feature.group,org.moflon.core.feature.feature.group

# Updatesite clean up
cd /home/vagrant
rm -rf /home/vagrant/updatesite-emoflon /home/vagrant/updatesite-emoflon.zip
rm -rf /home/vagrant/updatesite-hipe /home/vagrant/updatesite-hipe.zip

# Get example projects from ZIP
cd /home/vagrant
mkdir -p /home/vagrant/emoflon-projects
#unzip workspace.zip -d /home/vagrant/emoflon-projects
#rm -f workspace.zip
# TODO

# Import example projects into default workspace
#cd /home/vagrant/eclipse-apps/eclipse
#./eclipse -noSplash -consoleLog -data /home/vagrant/eclipse-workspace -application com.seeq.eclipse.importprojects.headlessimport -importProject /home/vagrant/emoflon-projects/
# TODO

log "Finished provisioning."
