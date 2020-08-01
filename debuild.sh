#!/bin/bash

if [[ "x${UID}X" != "x65587X" ]]; then
	echo "ERROR: You have to run this on Docker." 1>&2
	exit 1
fi

cp -r -- "/debuild/build/"{"${_NAME}-source","${_NAME}"}
sudo rm -rf -- "/debuild/build/${_NAME}/"{.git,LICENSE.md,README.md,build.sh,debuild.sh,Dockerfile}
cd -- "/debuild/build/${_NAME}/.."
dpkg -b -- "${_NAME}"
sudo mv -- "${_NAME}.deb" /deb
sudo chown -- "${UGID}" "/deb/${_NAME}.deb"
