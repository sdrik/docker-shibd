#!/bin/bash

SHIBD_USER="${SHIBD_USER:-_shibd}"
SHIBD_GROUP="${SHIBD_GROUP:-_shibd}"

for f in $(ls /etc/shibboleth.defaults)
do
	[ -f /etc/shibboleth/$f ] || cp -a /etc/shibboleth.defaults/$f /etc/shibboleth/
done

shib-keygen -b -n sp-signing -u ${SHIBD_USER} -g ${SHIBD_GROUP}
shib-keygen -b -n sp-encrypt -u ${SHIBD_USER} -g ${SHIBD_GROUP}

exec "$@"
