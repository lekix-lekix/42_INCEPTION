cd /var/www/html && \
wp core download --allow-root;
wp config create --allow-root \
    --dbname=wordpress_db \
    --dbuser=le_supervisor \
    --dbpass=coucoutoi \
    --dbhost=mariadb:3306 \
    --force;

wp config set WP_HOME 'https://localhost' --allow-root;
wp config set WP_SITEURL 'https://localhost' --allow-root;

cd /var/www/html && \
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