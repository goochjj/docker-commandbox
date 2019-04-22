#!/bin/bash

if [ -z "$COMMANDBOX_VERSION" ]; then
  echo "CommandBox Version not supplied via variable COMMANDBOX_VERSION"
  exit 1
fi

# Make sure errors (like curl failing, or unzip failing, or anything failing) fails the build
set -ex

# Installs the latest CommandBox Binary
mkdir -p /tmp
curl -k  -o /tmp/box.zip -location "https://downloads.ortussolutions.com/ortussolutions/commandbox/${COMMANDBOX_VERSION}/commandbox-bin-${COMMANDBOX_VERSION}.zip"
unzip /tmp/box.zip -d ${BIN_DIR} && chmod 755 ${BIN_DIR}/box

mv ${BIN_DIR}/box ${BIN_DIR}/box.real
( echo "#!/bin/sh"; echo "exec ${BIN_DIR}/box.real -CommandBox_home=$HOME/.CommandBox"' "$@"' ) >${BIN_DIR}/box && chmod 755 ${BIN_DIR}/box


$BUILD_DIR/util/optimize.sh
