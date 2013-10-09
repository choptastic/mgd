#!/bin/sh

if [ "$(whoami)" = "root" ]; then
	echo "Installing mgd (Minimal Git Deploy)."
	cp mgd.sh /usr/bin/mgd
	chmod 755 /usr/bin/mgd

	echo "mgd installed as /usr/bin/mgd"
else
	echo "Error: This must be run as root"
fi
