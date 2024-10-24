FROM	debian:bullseye-slim

RUN		apt update -y && apt upgrade -y && apt -y install wget && apt install -y php7.4
RUN		apt install -y php-fpm php-mysqli mariadb-client

COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY	./tools/auto-config.sh /

RUN		chmod 755 ./auto-config.sh

EXPOSE	9000

CMD		["/auto-config.sh"]
