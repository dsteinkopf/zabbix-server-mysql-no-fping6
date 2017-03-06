FROM zabbix/zabbix-server-mysql:ubuntu-latest

MAINTAINER Dirk Steinkopf "https://github.com/dsteinkopf"

RUN mv /usr/bin/fping6 /usr/bin/fping6.hide

RUN apt-get update && \
        apt-get -y dist-upgrade && \
        apt-get -y autoremove && \
        apt-get clean && \
        apt-get install -y \
                python-pip \
                python-requests

RUN pip install requests

