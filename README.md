# zabbix-server-mysql-no-fping6
Zabbix server avoiding problems without ipv6 and containing snmp+snmp-mibs-downloader.

This is almost identical to zabbix/zabbix-server-mysql:ubuntu-latest - but has the following changes:

* fping6 renamed to fping6.hide to make in invisible to zabbix. So zabbix won't try ipv6. - Without this patch I got some problems with ping-checks (e.g. wrong paket loss values).
* Install packages snmp and snmp-mibs-downloader. (Had to add multiverse repos to do so.)
* Install package freeradius-utils to be able to implement scripts checking a radius server
