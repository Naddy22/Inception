#!/bin/bash

sudo service mysql start

until mysqladmin ping &>/dev/null; do
	echo "Waiting for MySQL to be ready..."
	sleep 2
done

mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test >> /dev/null

mysql -e "CREATE DATABASE IF NOT EXISTS \'${SQL_DATABASE}';"
mysql -e "CREATE USER IF NOT EXISTS \'${SQL_USER}\'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

exec mysqld_safe

# SQLFILE=tmp.sql

# if [ ! -d "/run/mysqld" ]; then
# 	mkdir -p /run/mysqld
# 	chown -R mysql:mysql /run/mysqld
# 	echo "Waiting on MariaDB daemon..."
# fi

# chown -R mysql:mysql /var/lib/mysql

# mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test >> /dev/null

# echo "FLUSH PRIVILEGES;" >> SQLFILE
# echo "CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;" >> SQLFILE
# echo "CREATE USER IF NOT EXISTS \`${DATABASE_USER}\`@'%' IDENTIFIED BY '${DATABASE_USER_PW}';" >> SQLFILE
# echo "GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO \`${DATABASE_USER}\`@'%';" >> SQLFILE
# echo "ALTER USER \`root\`@\`localhost\` IDENTIFIED BY '${DATABASE_ADMIN_PW}';" >> SQLFILE
# echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> SQLFILE
# echo "FLUSH PRIVILEGES;" >> SQLFILE

# mysqld --user=mysql --bootstrap --silent < SQLFILE

# rm -rf SQLFILE

# echo "MariaDB has started!"
# exec mysqld_safe