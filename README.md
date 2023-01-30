# Zabbix - Mysql - Docker Compose

This git use image from zabbix v.6-latest and mysql:latest

for access the apps use http://yourip:8080 and for agent in port 10050

I have no responsible with your data if loses / crash after install this zabbix-docker
## Installation

Clone this project

```bash
    gh repo clone taufikrendi/zabbix-dockerfile
    or 
    git clone https://github.com/taufikrendi/zabbix-dockerfile.git
```

After clone you need to compose this docker-compose file with this command 

```bash
    docker-compose up -d
```

Then Migrate database with 

```bash
    docker exec -it <container_name> bash

    sh /var/www/mysql.sh
```

And you need to run Web Installation

```bash
    http://localhost:8080/
```
## Authors

- [@taufikrendi](https://github.com/taufikrendi) - Taufik Rendi Anggara

