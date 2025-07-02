FROM debian:11.11

WORKDIR /inception

COPY ./srcs/wordpress .

# RUN mkdir -p /home/kipouliq/data/wordpress_files

RUN apt update -y && \
    apt-get install -y --no-install-recommends \
    php-fpm php-mysqli php netcat curl ca-certificates

RUN mkdir -p /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN chmod +x ./wordpress_init.sh

CMD ["./wordpress_init.sh"]
