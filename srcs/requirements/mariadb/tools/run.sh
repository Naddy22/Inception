#!/bin/bash

SQLFILE=tmp.sql

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	echo "Waiting on MariaDB daemon..."
fi

chown -R mysql:mysql /var/lib/mysql

mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test >> /dev/null

echo "FLUSH PRIVILEGES;" >> SQLFILE
echo "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" >> SQLFILE
echo "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" >> SQLFILE
echo "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';" >> SQLFILE
echo "ALTER USER \`root\`@\`localhost\` IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" >> SQLFILE
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> SQLFILE
echo "FLUSH PRIVILEGES;" >> SQLFILE

mysqld --user=mysql --bootstrap --silent < SQLFILE

rm -rf SQLFILE

echo "MariaDB has started!"
exec mysqld_safe