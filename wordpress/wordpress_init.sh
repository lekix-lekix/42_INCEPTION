# cd /var/www/html
# su -s /bin/bash -c "
#     cd /var/www/html &&
#     wp core download --allow-root &&
#     wp config create --allow-root \
#         --dbname=wordpress_db \
#         --dbuser=le_supervisor \
#         --dbpass=coucoutoi \
#         --dbhost=mariadb &&
#     wp core install --allow-root \
#         --url=https://localhost \
#         --title='C est mon site' \
#         --admin_user=supervisor \
#         --admin_password=password \
#         --admin_email=moi@coucou.com
# " wordpress

# # useradd -m -s /bin/bash wordpress
# # groupadd wordpress

# # wp core version

# php-fpm7.4 -F


#!/bin/bash

# Attendre la base de données
until nc -z mariadb 3306; do
    echo "Waiting for MariaDB..."
    sleep 1
done

# Télécharger et configurer WordPress
cd /var/www/html &&
echo 'Downloading WordPress core...';
wp core download --allow-root;
echo 'Creating/recreating wp-config.php...';
wp config create --allow-root \
    --dbname=wordpress_db \
    --dbuser=le_supervisor \
    --dbpass=coucoutoi \
    --dbhost=mariadb:3306 \
    --force;

# Forcer la définition des constantes (écrase les valeurs existantes)
echo 'Setting WordPress constants...' &&
wp config set WP_DEBUG false --raw --allow-root &&
wp config set WP_DEBUG_LOG false --raw --allow-root &&
wp config set FORCE_SSL_ADMIN true --raw --allow-root &&
wp config set WP_HOME 'https://localhost' --allow-root &&
wp config set WP_SITEURL 'https://localhost' --allow-root

# Installer WordPress
cd /var/www/html &&
echo 'Installing WordPress...' &&
wp core install --allow-root \
    --url='https://localhost/' \
    --title='C est mon site' \
    --admin_user=supervisor \
    --admin_password=password \
    --admin_email=moi@coucou.com \
    --skip-email

chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

# Lancer PHP-FPM
exec php-fpm7.4 -F