FROM debian:11.11

WORKDIR /inception

RUN apt update -y && apt-get install -y --no-install-recommends \
    php-fpm netcat

COPY ./wordpress/info.php /var/www/html

RUN mkdir -p /run/php

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# CMD ["cat", "/etc/php/7.4/fpm/pool.d/www.conf"]
CMD ["php-fpm7.4", "-F"]