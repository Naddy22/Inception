FROM	debian:bullseye

RUN		apt update && apt upgrade -y
RUN		apt install -y nginx openssl

RUN 	mkdir -p /etc/nginx/ssl
RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=namoisan.42.fr/UID=namoisan"

COPY	conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN		mkdir -p /var/run/nginx && chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE	443

CMD 	[ "nginx", "-g", "daemon off;" ]