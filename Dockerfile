FROM zabbix/zabbix-server-mysql:ubuntu-latest

MAINTAINER Dirk Steinkopf "https://github.com/dsteinkopf"

RUN sed -i 's/Fping6Location=\(.*\)/Fping6Location=disable/' /etc/zabbix/zabbix_server.conf

USER root

# enable the multiverse (snmp-mibs-downloader comes from there)
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ bionic multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu/ bionic-updates multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu/ bionic-security multiverse' >> /etc/apt/sources.list

# bc is for some externalscripts (e.g. zext_ssl_cert.sh)

RUN apt-get update && \
        apt-get -y dist-upgrade && \
        apt-get -y autoremove && \
        apt-get clean && \
        apt-get install -y \
                bc \
                python-pip \
                python-requests \
		snmp \
		snmp-mibs-downloader \
                jq \
                curl \
		freeradius-utils

RUN apt install dumb-init

# seems important for mib lookup to work:
ENV MIBDIRS=/var/lib/snmp/mibs/ietf:/var/lib/snmp/mibs/iana:/usr/share/snmp/mibs:/var/lib/zabbix/mibs

# enable snmp mibs loading:
# remove problematic mibs which result in errors and are not needed (...why is this necessary?...)
RUN sed -i 's/^\( *mibs *:.*\)$/# \1/g' /etc/snmp/snmp.conf && \
	rm -f /var/lib/snmp/mibs/ietf/SNMPv2-PDU && \
	snmptranslate .iso.3.6.1.6.3.1.1.5.3

RUN pip install requests

USER 1997
