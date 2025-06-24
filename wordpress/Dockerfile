FROM debian:11.11

WORKDIR /inception

COPY ./wordpress .

RUN apt update -y && \
    apt-get install -y --no-install-recommends \
    php-fpm php-mysqli php netcat curl ca-certificates

COPY ./wordpress/info.php /var/www/html/

RUN mkdir -p /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Laisser php-fpm tourner avec www-data
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# NE PAS changer user/group du pool

CMD ["bash", "./wordpress_init.sh"]
