SHELL = /bin/bash
DK_COMPOSE = "./srcs/docker-compose.yml"
DATA_PATH = "$(HOME)/data/"

all: data build run

data:
	mkdir -p $(HOME)/data
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress

build:
	docker-compose -f $(DK_COMPOSE) build

run:
	docker-compose -f $(DK_COMPOSE) up

stop:
	docker-compose -f $(DK_COMPOSE) down

check:
	docker-compose -f $(DK_COMPOSE) ps

log:
	docker-compose -f $(DK_COMPOSE) logs

nginx:
	docker exec -it nginx $(SHELL)

mariadb:
	docker exec -it mariadb $(SHELL)

wordpress:
	docker exec -it wordpress $(SHELL)

fclean: 
	make stop
	docker rmi -f $$(docker images -qa); \
	docker rm -vf $$(docker ps -aq); \
	docker system prune --all --volumes
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume ls -q | xargs docker volume rm; \
	else \
		echo "No volumes to delete."; \
	fi
	sudo rm -rf $(DATA_PATH)

eval:
	docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q) 2>/dev/null

re: fclean all

.PHONY: all re fclean down build eval