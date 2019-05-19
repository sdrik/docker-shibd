FROM debian:stretch-backports
RUN for pkg in \
	init-system-helpers \
	liblog4shib2 \
	libxerces-c3.2 \
	libxml-security-c20 \
	libxmltooling8 \
	libsaml10 \
	opensaml-schemas \
	xmltooling-schemas \
	libshibsp8 \
	libshibsp-plugins \
	shibboleth-sp-utils \
	; do echo "Package: ${pkg}\nPin: release n=stretch-backports\nPin-Priority: 990\n\n" \
	; done > /etc/apt/preferences.d/shibboleth-backports \
	&& apt-get update && apt-get upgrade -y && apt-get install -y \
		shibboleth-sp-utils \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN cp -a /etc/shibboleth /etc/shibboleth.defaults

CMD ["/usr/sbin/shibd","-fF"]
