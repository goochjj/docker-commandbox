#!/bin/bash

# Make sure errors (like curl failing, or unzip failing, or anything failing) fails the build
set -ex

# Installs the latest CommandBox Binary
cd "$HOME"
echo "Expanding box"
box version
echo "$(box version) successfully installed"

# Cleanup CommandBox modules which would not be necessary in a Container environment
SYSTEM_EXCLUDES=( "coldbox" "contentbox" "cachebox" "logbox" "games" "wirebox" )
MODULE_EXCLUDES=( "cfscriptme-command" "cb-module-template" )

for mod in "${SYSTEM_EXCLUDES[@]}"
do
	rm -rf $HOME/.CommandBox/cfml/system/modules_app/${mod}-commands
done

for mod in "${MODULE_EXCLUDES[@]}"
do
	rm -rf $HOME/.CommandBox/cfml/modules/${mod}
done

# Need root for this
#$BUILD_DIR/util/optimize.sh
