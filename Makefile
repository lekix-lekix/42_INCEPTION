WP_VOL = /home/kipouliq/data/wordpress_files
DB_VOL = /home/kipouliq/data/mariadb_data

all :
	mkdir -p $(WP_VOL);
	mkdir -p $(DB_VOL);
	@if [ $$(docker ps --filter status=running | wc -l) -ne 1 ]; then \
		echo "Containers are already up!"; \
	else \
		docker compose up --build; \
	fi

clean :
	@containers=$$(docker ps -aq); \
	if [ $$(docker ps -aq | wc -l) -ne 0 ]; then \
		docker stop $$containers && docker rm -v $$containers; \
	fi
	
fclean : clean
	@images=$$(docker images -aq); \
	if [ $$(docker images -aq | wc -l) -ne 0 ]; then \
		docker run --rm -v $(WP_VOL):/data wordpress-php sh -c "rm -rf /data/*"; \
		docker run --rm -v $(DB_VOL):/data wordpress-php sh -c "rm -rf /data/.init_done && rm -rf /data/*"; \
		docker rmi -f $$images; \
	fi
	@volumes=$$(docker volume ls -q); \
	if [ $$(docker volume ls -q | wc -l) -ne 0 ]; then \
		docker volume rm $$volumes; \
	fi
	@if [ $$(docker network ls -f name=42_inception -q | wc -l) -ne 0 ]; then \
		docker network rm $$(docker network ls -f name=42_inception -q); \
	fi
	@docker system prune -af --volumes
	rm -rf /home/kipouliq/data

re : fclean
	make all

.PHONY : all clean fclean re
