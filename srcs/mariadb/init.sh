#!/bin/bash

echo "my pid is $$"

mysql_install_db

mysqld --skip-networking &

sleep 5

mysql -u root -p"$MARIADB_ROOT_PWD" <<EOF
CREATE DATABASE IF NOT EXISTS \`$MARIADB_DATABASE\`;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PWD';
DELETE FROM mysql.user WHERE user='root' AND host != 'localhost';
CREATE USER IF NOT EXISTS '$MARIADB_WP_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MARIADB_DATABASE\`.* TO '$MARIADB_WP_USER'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p"$MARIADB_ROOT_PWD" shutdown

exec mysqld
