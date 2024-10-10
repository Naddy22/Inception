FROM	debian:buster

RUN		apt upgrade && \
		apt install nginx -y && \
		apt install OpenSSL -y

RUN 	mkdir -p /etc/nginx/ssl && \
		openssl req -x509 -nodes \
		-out /etc/nginx/ssl/inception.crt \
		-keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=namoisan.42.fr/UID=namoisan"

COPY	conf/nginx.conf /etc/nginx/nginx.conf

RUN		mkdir -p /var/run/nginx && \
		chmod 755 /var/www/html && \
		chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]