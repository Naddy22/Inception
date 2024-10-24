#!/bin/bash

if [ ! -d /run/php ]
then
	service php7.4-fpm start
	service php7.4-fpm stop
fi

if [[ ${SQL_USER,,} == *"admin" ]]
then
	echo "--> Username should not contain admin"
	exit
fi

if [[ ${SQL_PASSWORD,,} == *${SQL_USER,,}* ]]
then
	echo "--> Password should not contain username"
	exit
fi

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

sleep 10

cd /var/www/html

if [ ! -f wp-config.php ]
then
	wp core download --allow-root
	wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb:3306
	wp core install --url="namoisan.42.fr" \
					--title=$WP_TITLE \
					--admin_user=$WP_USER \
					--admin_password=$WP_PASSWORD \
					--admin_email=$WP_EMAIL \
					--skip-email --allow-root
	# wp theme install teluro --path='/var/www/html' --activate --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
else
	echo "Wordpress already configured."
fi

/usr/sbin/php-fpm7.4 -F