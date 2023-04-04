FROM php:8.0-fpm-alpine

# siteye hizmet veren uygulamaların takibi için burası kullanılıyormuş.
# nginx.conf içinde de var.
WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql