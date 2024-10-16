FROM	debian:bullseye

RUN		apt update -y && apt upgrade -y
RUN		apt-get install mariadb-server -y

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY	./tools/run.sh /

RUN		chmod 755 /etc/mysql/mariadb.conf.d/50-server.cnf && chmod 755 run.sh

CMD		["./run.sh"]