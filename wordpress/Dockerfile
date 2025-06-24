FROM debian:11.11

WORKDIR /inception

COPY ./wordpress .

RUN apt update -y && apt-get install -y --no-install-recommends \
    php-fpm php-mysqli php netcat curl ca-certificates

COPY ./wordpress/info.php /var/www/html/

RUN mkdir -p /run/php

# Installer WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Créer user wordpress pour l'install
RUN useradd -m wordpress && \
    chown -R wordpress:www-data /var/www/html && \
    chmod -R u=rwX,g=rX,o= /var/www/html

# Laisser php-fpm tourner avec www-data
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# NE PAS changer user/group du pool

CMD ["bash", "./wordpress_init.sh"]
