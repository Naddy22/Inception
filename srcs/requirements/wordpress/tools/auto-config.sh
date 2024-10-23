#!/bin/bash

if [ ! -d /run/php ]
then
	service php7.4-fpm start
	service php7.4-fpm stop
fi

# if [ ${SQL_USER,,} == *"admin" ]
# then
# 	echo "--> Username should not contain admin"
# 	exit
# fi

# if [ ${SQL_PASSWORD,,} == *{SQL_USER,,}* ]
# then
# 	echo "--> Password should not contain username"
# 	exit
# fi

# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
# chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# sleep 10

# cd /var/www/html

# if [ ! -f wp-config.php ]
# then
# 	wp core download --allow-root
# 	wp config create	--allow-root \
# 						--dbname=$SQL_DATABASE \
# 						--dbuser=$SQL_USER \
# 						--dbpass=$SQL_PASSWORD \
# 						--dbhost=mariadb:3306
# 	wp core install --url='namoisan.42.fr' \
# 					--title=$WP_TITLE \
# 					--admin_user=$WP_USER \
# 					--admin_password=$WP_PASSWORD \
# 					--admin_email=$WP_EMAIL \
# 					--skip-email --allow-root
# 	# wp theme install teluro --path='/var/www/html' --activate --allow-root
# 	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
# else
# 	echo "Wordpress already configured."
# fi

# /usr/sbin/php-fpm7.4 -F


cd /var/www/html

# Check if WordPress is already downloaded
if [ ! -f wp-config.php ]; then
    echo "Downloading wp-cli..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar

    # Downloads WordPress core files."
    ./wp-cli.phar core download --allow-root

    # Creates wp-config.php"
    ./wp-cli.phar config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$(cat $SQL_PASSWORD) --dbhost=mariadb:3306 --allow-root

    # auto-installs WordPress.
    ./wp-cli.phar core install --url='namoisan.42.fr' --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=$WP_EMAIL --allow-root

else
    echo "WordPress is already installed. Skipping download and configuration."
fi

    ./wp-cli.phar user create $WP_USER $WP_EMAIL --user_pass=$WP_PASSWORD --role=author --allow-root

php-fpm7.4 -F