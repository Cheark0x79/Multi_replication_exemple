# Multi replication

## Task SQL
- [x] Dump
- [x] Master/Slave
- [x] Master/Master
- [x] indicater performance


## Task Postgreysql
- [ ] Master/Slave
- [ ] Master/Master

### How to use
- cd ./master-slave
- docker-compose up -d
- and follow tuto

## Master/Slave

# Master config

## ADD Config replication

add in /etc/mysql/my.cnf

```bash
[mariadb]
log-bin
server-id=1
log-basename=master1
binlog-format=mixed
```

- need restart

## Create user replication

```sql
CREATE USER 'replication_user'@'%' IDENTIFIED BY 'boite';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';
```

## Binary log

```sql
FLUSH TABLES WITH READ LOCK;
SHOW MASTER STATUS;
UNLOCK TABLES;
```

![master_status](./static/masterStatus.png)

- get
    - file
    - Position

# Slave

## Add config  replication

add in /etc/mysql/my.cnf

```bash
[mariadb]
server-id=<number of server>
```

- need restart

## Start slave

```sql
CHANGE MASTER TO
  MASTER_HOST=<Host>,
  MASTER_USER='replication_user',
  MASTER_PASSWORD='boite',
  MASTER_PORT=3306,
  MASTER_LOG_FILE=<file>,
  MASTER_LOG_POS=<Possition>,
  MASTER_CONNECT_RETRY=10,
	MASTER_USE_GTID = slave_pos;

START SLAVE;
```

## Check slave is ready

```sql
SHOW SLAVE STATUS \G
```
![slavesSatus](./static/slaveSatus.png)

If slave_*_running is Good


# Master/Master

### warning
if docker-compose faile attached failed
- comment on the line attached (line 57 ./master-slave/docker-container.yml)


## Master1 config

### Create User

```sql
CREATE USER 'master_user1'@'%' IDENTIFIED BY 'boite';
GRANT REPLICATION SLAVE ON *.* TO 'master_user1'@'%';
FLUSH PRIVILEGES;
```

```sql
Create database badaboum;
```

### Get master status

```sql
SHOW MASTER STATUS;
```

![masterSatus](./static/masterStatus.png)

## Master2 config

### Create User

```sql
CREATE USER 'master_user1'@'%' IDENTIFIED BY 'boite';
GRANT REPLICATION SLAVE ON *.* TO 'master_user1'@'%';
FLUSH PRIVILEGES;
```

## Create database

```sql
Create database badaboum;
```

### Slave Config

```sql
STOP SLAVE;
CHANGE MASTER TO MASTER_HOST = "SQL-MASTER01",
MASTER_USER = "master_user1",
MASTER_PASSWORD = "boite",
MASTER_PORT=3306,
MASTER_LOG_FILE = "<file>",
MASTER_LOG_POS = <Position>,
MASTER_CONNECT_RETRY=10;

START SLAVE;
```

### Get Master status

```sql
SHOW MASTER STATUS;
```

![masterSatus](./static/masterStatus.png)

## Master1 slave config

```sql
STOP SLAVE;

CHANGE MASTER TO MASTER_HOST = "SQL-MASTER02",
MASTER_USER = "master_user1",
MASTER_PASSWORD = "boite",
MASTER_PORT=3306,
MASTER_LOG_FILE = "<file>",
MASTER_LOG_POS = <Position>,
MASTER_CONNECT_RETRY=10;

START SLAVE;
```

### Check config

```sql
show slave status\G
```


![slavesSatus](./static/slaveSatus.png)
