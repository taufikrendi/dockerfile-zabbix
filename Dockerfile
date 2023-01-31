FROM ubuntu:22.04

Maintainer Taufik Rendi Anggara <taufik.rendi.anggara@gmail.com>

ARG DB_IP=db
ARG DB_USERNAME=zabbix
ARG DB_PASSWORD=zabbix
ARG DB_NAME=zabbix
ARG	PORT=8080
ARG AGENT_PORT=10051

ENV DEBIAN_FRONTEND noninteractive
ENV DB_IP=$DB_IP
ENV DB_USERNAME=$DB_USERNAME
ENV DB_PASSWORD=$DB_PASSWORD
ENV DB_NAME=$DB_NAME
ENV PORT=$PORT
ENV AGENT_PORT=$AGENT_PORT

RUN apt-get update -y && apt install -y tcl && apt install -y language-pack-en && apt-get -y install wget
RUN wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4%2Bubuntu22.04_all.deb
RUN dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
RUN apt -y update
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure locales
RUN update-locale
RUN apt install -y zabbix-server-mysql zabbix-sql-scripts zabbix-agent zabbix-nginx-conf zabbix-frontend-php

COPY zabbix-server.conf /etc/zabbix/zabbix-server.conf
COPY entrypoint.sh /usr/local/bin
COPY nginx.conf /etc/zabbix/nginx.conf
COPY zabbix.conf.php /etc/zabbix/web/zabbix.conf.php

RUN service zabbix-server start
RUN service nginx start

EXPOSE $PORT
EXPOSE $AGENT_PORT

CMD ["nginx", "-g", "daemon off;"]
CMD ["/usr/sbin/zabbix_server", "--foreground", "-c", "/etc/zabbix/zabbix_server.conf"]