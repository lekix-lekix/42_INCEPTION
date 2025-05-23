FROM debian:11.11

WORKDIR /inception

COPY . .

RUN apt-get update -y && apt-get -y upgrade\
    apt install nginx openssl -y \
    openssl req -x509 -nodes -days 365 \
        -subj "/C=FR/ST=Paris/L=Paris/O=No-organization/CN=localhost" \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
    cp /inception/nginx.conf /etc/nginx/nginx.conf \
    cp /inception/index.html /var/www/html;

EXPOSE 443

CMD ["nginx" , "-g", "daemon off;"]

# need to change CN for kipouliq later on