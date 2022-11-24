CREATE USER 'master_user1'@'%' IDENTIFIED BY '<password>';
GRANT REPLICATION SLAVE ON *.* TO 'master_user1'@'%';
