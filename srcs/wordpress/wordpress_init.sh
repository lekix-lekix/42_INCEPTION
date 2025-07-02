#!/bin/bash

# rm /var/lib/mysql/.init_done

cd /var/www/html && \
wp core download --allow-root;
wp config create --allow-root \
    --dbname=$MARIADB_DATABASE \
    --dbuser=$MARIADB_WP_USER \
    --dbpass=$MARIADB_PASSWORD \
    --dbhost=$WORDPRESS_DB_HOST \
    --force;

wp config set WP_HOME "$HOSTNAME" --allow-root;
wp config set WP_SITEURL "$HOSTNAME" --allow-root;

cd /var/www/html && \
wp core install --allow-root \
    --url=$HOSTNAME \
    --title='Inzepzion baby' \
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PWD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --skip-email

wp user create $WORDPRESS_EDITOR $WORDPRESS_EDITOR_EMAIL \
    --role=editor \
    --user_pass=$WORDPRESS_EDITOR_PWD \
    --allow-root

chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

exec php-fpm7.4 -F