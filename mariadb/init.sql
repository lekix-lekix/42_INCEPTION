CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER 'le_supervisor' IDENTIFIED BY 'coucoutoi';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'le_supervisor';
FLUSH PRIVILEGES;