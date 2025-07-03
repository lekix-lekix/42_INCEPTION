FROM debian:bullseye

WORKDIR /inception

COPY ./srcs/mariadb .

HEALTHCHECK --interval=5s --timeout=3s --start-period=30s --retries=5 \
    CMD mysqladmin ping -h localhost || exit 1

RUN apt-get update -y && apt-get -y upgrade && \
    apt install mariadb-server netcat -y

RUN sed -i 's|^# port = .*|port = 3306|' /etc/mysql/my.cnf && \
    sed -i 's|^socket = .*|# socket = /run/mysqld/mysqld.sock|' /etc/mysql/my.cnf && \
    sed -i 's|^bind-address .*|bind-address = 0.0.0.0|' /etc/mysql/mariadb.conf.d/50-server.cnf
    
RUN mkdir -p /run/mysqld
    
RUN chown mysql:mysql /run/mysqld

RUN chmod +x ./init.sh

ENTRYPOINT ["./init.sh"]