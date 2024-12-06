all:
	mkdir -p $(HOME)/data/html
	mkdir -p $(HOME)/data/mariadb
	make up

up: build
	sudo docker-compose -f ./srcs/docker-compose.yml up

build:
	sudo docker-compose -f ./srcs/docker-compose.yml build

stop:
	sudo docker-compose -f ./srcs/docker-compose.yml stop

restart:
	sudo docker-compose -f ./srcs/docker-compose.yml restart

remove:
	sudo docker-compose -f ./srcs/docker-compose.yml rm

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down --volumes --rmi all

fclean: down
	sudo rm -rf  $(HOME)/data/wordpress
	sudo rm -rf  $(HOME)/data/mariadb
	sudo docker system prune -af --volumes
re: fclean all

.PHONY: up build stop restart remove down fclean re
