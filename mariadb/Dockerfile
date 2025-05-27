FROM debian:11.11

WORKDIR /inception

COPY . .

RUN apt-get update -y && apt-get -y upgrade

RUN apt install mariadb-server -y

RUN mkdir -p /run/mysqld

RUN chown mysql:mysql /run/mysqld

RUN mysqld_safe &

RUN sleep 3

CMD ["mysql_secure_installation"]         