all :
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
	@images=$$(docker images -aq); \
	if [ $$(docker images -aq | wc -l) -ne 0 ]; then \
		docker rmi -f $$images; \
	fi
	
fclean : clean
	@volumes=$$(docker volume ls -q); \
	if [ $$(docker volume ls -q | wc -l) -ne 0 ]; then \
		docker volume rm $$volumes; \
	fi
	@if [ $$(docker network ls -f name=42_inception -q | wc -l) -ne 0 ]; then \
		docker network rm $$(docker network ls -f name=42_inception -q); \
	fi
	@docker system prune -af --volumes

re : fclean
	make all

.PHONY : all clean fclean re
