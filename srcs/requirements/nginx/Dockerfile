FROM	debian:buster

RUN		apt upgrade &&  apt install nginx -y && mkdir -p /etc/nginx/ssl && \
		apt install OpenSSL -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
	/etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=namoisan.42.fr/UID=namoisan"