#!/bin/bash

#
# Config
#

ECLIPSE_ARCHIVE=eclipse-emoflon-linux-user-ci
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

# GIPS Eclipse (CI)
log "Installing eMoflon::IBeX Eclipse (CI)."
mkdir -p ~/eclipse-apps-ci
cd ~/eclipse-apps-ci

# Get Eclipse (CI)
if [[ ! -f "./$ECLIPSE_ARCHIVE.zip" ]]; then
	log "Downloading specified eMoflon::IBeX Eclipse archive from Github."
        wget -q $EMOFLON_SRC_URL
fi

if [[ ! -f "./$ECLIPSE_ARCHIVE.zip" ]]; then
        log "Download of eMoflon::IBeX Eclipse (CI) archive failed."
        exit 1;
fi

unzip -qq -o $ECLIPSE_ARCHIVE.zip
rm -f $ECLIPSE_ARCHIVE.zip

# Install eMoflon::IBeX from custom updatesite to included Eclipse (VM)
cd /home/vagrant
unzip updatesite.zip -d /home/vagrant/updatesite
cd /home/vagrant/eclipse-apps/eclipse
./eclipse -noSplash -consoleLog -application org.eclipse.equinox.p2.director -repository file:///home/vagrant/updatesite/ -uninstallIU org.emoflon.ibex.ide.democles.feature.feature.group,org.emoflon.ibex.ide.feature.feature.group,org.emoflon.ibex.ide.hipe.feature.feature.group,org.emoflon.ibex.tgg.editor.feature.feature.group,org.moflon.core.feature.feature.group
./eclipse -noSplash -consoleLog -application org.eclipse.equinox.p2.director -repository file:///home/vagrant/updatesite/ -installIU org.emoflon.ibex.ide.democles.feature.feature.group,org.emoflon.ibex.ide.feature.feature.group,org.emoflon.ibex.ide.hipe.feature.feature.group,org.emoflon.ibex.tgg.editor.feature.feature.group,org.moflon.core.feature.feature.group

# Updatesite clean up
cd /home/vagrant
rm -rf /home/vagrant/updatesite /home/vagrant/updatesite.zip

# Get example projects from ZIP
cd /home/vagrant
mkdir -p /home/vagrant/emoflon-projects
unzip workspace.zip -d /home/vagrant/emoflon-projects
rm -f workspace.zip

# Import example projects into default workspace
cd /home/vagrant/eclipse-apps-ci/eclipse
./eclipse -noSplash -consoleLog -data /home/vagrant/eclipse-workspace -application com.seeq.eclipse.importprojects.headlessimport -importProject /home/vagrant/emoflon-projects/

# Eclipse CI clean up
cd /home/vagrant
rm -rf /home/vagrant/eclipse-apps-ci

log "Finished provisioning."
