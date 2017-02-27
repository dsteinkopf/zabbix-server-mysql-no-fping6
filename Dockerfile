FROM zabbix/zabbix-server-mysql:ubuntu-latest

RUN mv /usr/bin/fping6 /usr/bin/fping6.hide

