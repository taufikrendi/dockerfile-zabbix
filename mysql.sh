mysql -uroot -pzabbix -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -uroot -pzabbix -e "set global log_bin_trust_function_creators = 1;"

zcat /etc/mysql/server.sql.gz | mysql  --default-character-set=utf8mb4 -uroot -pzabbix zabbix

mysql -uroot -pzabbix -e "set global log_bin_trust_function_creators = 0;"