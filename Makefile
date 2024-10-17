SHELL = /bin/bash
DK_COMPOSE = "./srcs/docker-compose.yml"
DATA_PATH = "$(HOME)/$(USER)/data/"

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
	docker-compose -f $(DK_COMPOSE) down -v --rmi all --remove-orphans --timeout - || true
	docker system prune -af || true
	docker network prune -f || true
	docker volume prune -f || true
	sudo rm -rf $(DATA_PATH)

re: fclean all

.PHONY: all re fclean down build