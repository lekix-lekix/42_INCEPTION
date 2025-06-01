# FROM debian:11.11

# WORKDIR /inception

# COPY ./wordpress .

# RUN apt update -y && apt-get install -y --no-install-recommends \
#     php-fpm php-mysqli php netcat curl ca-certificates 

# COPY ./wordpress/info.php /var/www/html/

# RUN mkdir -p /run/php

# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
#     chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# RUN useradd wordpress && echo "wordpress:password" | chpasswd && chown -R wordpress:www-data /var/www/html

# # RUN chown -R www-data:www-data /var/www/html && \
#     # find /var/www/html -type d -exec chmod 755 {} \; && \
#     # find /var/www/html -type f -exec chmod 644 {} \;

# # USER wordpress

# RUN chmod -R u=rwX,g=rX,o= /var/www/html && \
#     chown -R wordpress:wordpress /var/www/html && \
#     usermod -a -G wordpress www-data && \
#     sed -i 's|^listen.owner = .*|listen.owner = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     sed -i 's|^listen.group = .*|listen.group = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     sed -i 's|^listen.mode = .*|listen.mode = 0660|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     sed -i 's|^user = .*|user = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     sed -i 's|^group = .*|group = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf

# CMD ["bash", "./wordpress_init.sh"]

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
