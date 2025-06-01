FROM debian:bullseye

WORKDIR /inception

COPY ./nginx .

RUN apt-get update -y && apt-get upgrade -y && \
    apt install nginx openssl netcat curl -y && \
    openssl req -x509 -nodes -days 365 \
        -subj "/C=FR/ST=Paris/L=Paris/O=No-organization/CN=localhost" \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt && \
    cp ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx" , "-g", "daemon off;"]

# need to change CN for kipouliq later on