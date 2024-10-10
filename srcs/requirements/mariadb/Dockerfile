FROM	debian:buster

RUN		apt upgrade -y && \
		apt install mariadb-serveur -y

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

CMD		["./tools/run.sh"]