all: build
	@docker-compose -f ./srcs/docker-compose.yml up

build:
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	@sudo docker-compose -f ./srcs/docker-compose.yml build

down:
	@sudo docker-compose -f ./srcs/docker-compose.yml down

clean: 
	@sudo rm -rf $(HOME)/data

fclean: down clean
	-@sudo docker volume rm $$(sudo docker volume ls -q)
	@sudo docker system prune -af --volumes

re: fclean all

.PHONY: all build down re clean fclean