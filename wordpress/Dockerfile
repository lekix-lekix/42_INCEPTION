FROM debian:11.11

WORKDIR /inception

RUN apt update -y && apt-get install -y --no-install-recommends \
    php-fpm php-mysqli php netcat curl ca-certificates 

COPY ./wordpress/info.php /var/www/html/

RUN mkdir -p /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN useradd wordpress && echo "wordpress:password" | chpasswd && chown -R wordpress:www-data /var/www/html

USER wordpress

RUN wp core download --path=/var/www/html/

RUN wp config create \
    --path=/var/www/html/ \
    --dbname=wordpress_db \
    --dbuser=le_supervisor \
    --dbpass=coucoutoi \
    --dbhost=mariadb 

RUN cd /var/www/html

RUN wp core install \
    --path=/var/www/html/ \
    --url=httsp://localhost:8080 \
    --title="C'est mon site" \
    --admin_user=supervisor \
    --admin_password=password \
    --admin_email=moi@coucou.com

USER root

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf
#     # sed -i 's|^listen.owner = .*|listen.owner = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     # sed -i 's|^listen.group = .*|listen.group = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     # sed -i 's|^listen.mode = .*|listen.mode = 0660|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     sed -i 's|^user = .*|user = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     sed -i 's|^group = .*|group = wordpress|' /etc/php/7.4/fpm/pool.d/www.conf && \
#     usermod -a -G wordpress www-data && \
#     chmod -R u=rwX,g=rX,o= /var/www/html && \
#     chown -R wordpress:wordpress /var/www/html

RUN wp core version

# CMD ["cat", "/etc/php/7.4/fpm/pool.d/www.conf"]
CMD ["php-fpm7.4", "-F"]