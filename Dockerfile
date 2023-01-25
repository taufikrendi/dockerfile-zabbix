FROM ubuntu:22.04

Maintainer Taufik Rendi Anggara <taufik.rendi.anggara@gmail.com>

ARG DB_IP=127.0.0.1
ARG DB_ROOT_USERNAME=root
ARG DB_USERNAME=zabbix
ARG DB_PASSWORD=zabbix
ARG DB_ROOT_PASSWORD=zabbix
ARG DB_NAME=zabbix
ARG	PORT=8080
ARG AGENT_PORT=10050

ENV DEBIAN_FRONTEND noninteractive
ENV DB_IP=$DB_IP
ENV DB_ROOT_USERNAME=$DB_ROOT_USERNAME
ENV DB_USERNAME=$DB_USERNAME
ENV DB_PASSWORD=$DB_PASSWORD
ENV DB_ROOT_PASSWORD=$DB_ROOT_PASSWORD
ENV DB_NAME=$DB_NAME
ENV PORT=$PORT
ENV AGENT_PORT=$AGENT_PORT

RUN apt-get update -y && apt install -y tcl
RUN apt-get -y install wget
RUN wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4%2Bubuntu22.04_all.deb
RUN dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
RUN apt -y update
RUN apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

RUN sed -i '2i listen 8080;' /etc/zabbix/nginx.conf
RUN sed -i '2i server_name 0.0.0.0;' /etc/zabbix/nginx.conf

COPY entrypoint.sh /usr/local/bin

EXPOSE $PORT

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/zabbix_server", "--foreground", "-c", "/etc/zabbix/zabbix_server.conf"]