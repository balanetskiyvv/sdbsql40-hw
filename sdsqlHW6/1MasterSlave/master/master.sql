CREATE USER 'balanetrepl'@'%' IDENTIFIED WITH mysql_native_password BY 'slavepass';
GRANT REPLICATION SLAVE ON *.* TO 'balanetrepl'@'%';
