FROM nginx:stable-alpine3.17

WORKDIR /etc/nginx/conf.d

COPY ./nginx/nginx.conf .

RUN mv nginx.conf default.conf

COPY /src /var/www/html