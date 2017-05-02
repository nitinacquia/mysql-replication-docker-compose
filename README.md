# Demo Steps

## Initialize Docker Containers
```
docker-compose up
```

## Login to Master
```
docker exec -i -t mysql-master /bin/bash
```

## Login to Slave 
```
docker exec -i -t mysql-slave /bin/bash
```

## Ping Master on Slave
```
ping mysql-master
```

## Ping Slave on master 
```
ping mysql-slave
```

## Login to MySQL
```
mysql -uroot -pmysql 
```

## Hostname 
```
select @@hostname;
```

## Change Database 
```
use acquia;
```

## Show tables 
```
show tables;
```

## Master Status
```
show master status\G
```

## Create demo tables
```
create table demo (id int);
show master status\G
```

## Insert Value
```
insert into demo value(1);
show master status\G
```

## Select tables
```
select * from demo;
show master status\G
```

## Replication User
```
GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'password';
```

## Change master pointing on Slave
```
CHANGE MASTER TO MASTER_HOST='mysql-master',MASTER_USER='slave_user', MASTER_PASSWORD='password';
show slave status\G
```

## Copy Existing data from master to slave using mysqldump
```
mysqldump -u root -pmysql -h mysql-master acquia > acquia-dbdump.sql
mysqldump -u root -pmysql -h mysql-master --master-data=1 acquia > acquia-dbdump.sql
```

## Dump restore
```
mysql -uroot -pmysql acquia < acquia-dbdump.sql
show slave status\G
```

## Insert Value
```
insert into demo value(2); 
show master status\G  
show slave status\G
```

## Start Slave
```
start slave;  
show master status\G  
show slave status\G
```

## Binlog and relay log files content
```
On Master
cd /var/log/mysql/
mysqlbinlog mysql-bin.000004

On Slave
cd /var/log/mysql/
mysqlbinlog mysql-relay-bin.000003
```
(Content will be same in both files) 
	
## Stop Slave
```
stop slave;
```

## Stop Slave (SQL Thread)
```
stop slave sql_thread;
insert on master ; 
show master/slave status
```

## Skip SQL Query
```
SET GLOBAL sql_slave_skip_counter = N #Stop Sql , insert , start sql
```

## Skip SQL Query
```
insert into demo value(7),(8); insert into demo value(9),(10);
```

## Show Binary Logs
```
show binary logs;
```

## Purge Binary Logs
```
PURGE BINARY LOGS TO 'mysql-bin.000003';
```

## Flush Logs (Stop Slave before running this)
```
flush logs; ##PURGE BINARY LOGS TO 'mysql-bin.000005';
```
What will happen on start slave? Restore using Dump Restore
