#!/usr/bin/env bash
# 4 - setup a primary-replica infrastructure using mysql

sudo ufw allow 3306/tcp
sudo ufw reload

sudo sed -i "s/^.?bind-address/bind-address    = 35.175.135.222\n
server-id = 1"\
  /etc/mysql/mysql.conf.d/mysqld.cnf

bind-address = web-01-ip
server_id = 1
log-bin = ON  #   or log_bin???

log-bin = /var/log/mysql/mysql-bin.log
binlog-do-db          = tyrell_corp  ???

sudo systemctl restart mysql
sudo mysqldump -uroot tyrell_corp  > /tmp/tyrell_corp.sql

CREATE USER 'replica_user'@'%' IDENTIFIED BY 'ubuntu10081963';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;

REVOKE ALL PRIVILEGES ON *.* FROM 'replica_user'@'%';
DROP USER 'replica_user'@'%';
CREATE USER 'replica_user'@'%' IDENTIFIED BY 'ubuntu10081963';
GRANT ALL PRIVILEGES ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;

CREATE USER 'replica_user'@'%' IDENTIFIED BY 'ubuntu10081963';
GRANT REPLICATION CLIENT ON *.* TO 'replica_user'@'%'
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%'
GRANT SELECT ON `tyrell_corp`.`nexus6` TO 'replica_user'@'%'
GRANT SELECT ON `mysql`.`user` TO 'replica_user'@'%'

FLUSH TABLES WITH READ LOCK;
SHOW MASTER STATUS

sudo mysqldump -u root tyrell_corp > tyrell_corp.sql
UNLOCK TABLES;

server-id = 2
CHANGE MASTER TO
  MASTER_HOST='35.175.135.222',
  MASTER_USER='replica_user',
  MASTER_PASSWORD='ubuntu10081963',
  MASTER_PORT=3306,
  MASTER_LOG_FILE='mysql-bin.000035',
  MASTER_LOG_POS=154,
  MASTER_CONNECT_RETRY=60;
