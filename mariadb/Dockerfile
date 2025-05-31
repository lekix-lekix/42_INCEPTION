FROM debian:11.11

WORKDIR /inception

COPY ./mariadb .

RUN apt-get update -y && apt-get -y upgrade && \
    apt install mariadb-server netcat -y

RUN sed -i 's|^# port = .*|port = 3306|' /etc/mysql/my.cnf && \
    sed -i 's|^socket = .*|# socket = /run/mysqld/mysqld.sock|' /etc/mysql/my.cnf && \
    sed -i 's|^bind-address .*|bind-address = 0.0.0.0|' /etc/mysql/mariadb.conf.d/50-server.cnf
    
RUN mkdir -p /run/mysqld
    
RUN chown mysql:mysql /run/mysqld
    
CMD ["bash", "./init.sh"]