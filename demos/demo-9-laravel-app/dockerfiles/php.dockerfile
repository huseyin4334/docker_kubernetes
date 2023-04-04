FROM php:8.0-fpm-alpine

# siteye hizmet veren uygulamaların takibi için burası kullanılıyormuş.
# nginx.conf içinde de var.
WORKDIR /var/www/html

COPY ./src .

RUN docker-php-ext-install pdo pdo_mysql

# recursively permission (-R) / www-data (user and group name)
RUN chown -R www-data:www-data /var/www/html