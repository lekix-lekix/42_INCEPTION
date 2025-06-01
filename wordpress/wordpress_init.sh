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

# Installer WordPress avec l'utilisateur wordpress
su -s /bin/bash -c "
cd /var/www/html &&
wp core download --allow-root &&
wp config create --allow-root \
    --dbname=wordpress_db \
    --dbuser=le_supervisor \
    --dbpass=coucoutoi \
    --dbhost=mariadb &&
wp core install --allow-root \
    --url=https://localhost \
    --title='C est mon site' \
    --admin_user=supervisor \
    --admin_password=password \
    --admin_email=moi@coucou.com
" wordpress

# Lancer PHP-FPM
exec php-fpm7.4 -F