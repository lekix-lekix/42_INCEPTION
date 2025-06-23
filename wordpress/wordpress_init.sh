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
su -s /bin/bash -c "
    cd /var/www/html &&
    echo 'Downloading WordPress core...' &&
    wp core download --allow-root &&
    echo 'Creating wp-config.php...' &&
    wp config create --allow-root \
        --dbname=mariadb \
        --dbuser=user \
        --dbpass=password \
        --dbhost=mariadb:3306
" www-data

# Ajouter la configuration PHP supplémentaire
cat >> /var/www/html/wp-config.php << 'EOF'
define('WP_DEBUG', false);
define('WP_DEBUG_LOG', false);
define('FORCE_SSL_ADMIN', true);
define('WP_HOME', 'https://localhost:8080');
define('WP_SITEURL', 'https://localhost:8080');
EOF

# Installer WordPress
su -s /bin/bash -c "
    cd /var/www/html &&
    echo 'Installing WordPress...' &&
    wp core install --allow-root \
        --url='https://localhost:8080' \
        --title='C est mon site' \
        --admin_user=supervisor \
        --admin_password=password \
        --admin_email=moi@coucou.com \
        --skip-email
" www-data

# Lancer PHP-FPM
exec php-fpm7.4 -F