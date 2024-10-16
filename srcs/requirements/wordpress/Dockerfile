FROM	debian:bullseye

RUN		apt update -y && apt upgrade -y && \
		apt -y install wget && \
		apt install -y php7.4\
		php-fpm\
		php-mysqli\
		mariadb-client\

RUN 	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
		cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
		# chown -R root:root /var/www/wordpress

COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE	9000

COPY	./tools/auto-config.sh /

RUN		chmod 755 ./auto-config.sh

CMD		["/auto-config.sh"]
