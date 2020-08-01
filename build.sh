#!/bin/bash
set -e

if [[ "x${UID}X" != "x0X" ]]; then
	echo "ERROR: You must run this as root." 1>&2
	exit 1
fi

if !(type docker >/dev/null); then
	echo "ERROR: Docker is not installing on this machine. Please install it and retry." 1>&2
	exit 1
fi

declare _WORKDIR="$(cd -- "$(dirname ${0})"; pwd)"
declare _NAME="serene-startdash"
cd ..
docker build -t build_serenestartdash ${_WORKDIR}
docker run -e "_NAME=${_NAME}" -e UGID="${UID}:$(id -u)" -v "${_WORKDIR}:/debuild/build/${_NAME}-source:ro" -v "${_WORKDIR}/out:/deb" -it build_serenestartdash
unset _WORKDIR _NAME
