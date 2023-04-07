FROM composer:latest

# That's for permissions
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

WORKDIR /var/www/html

ENTRYPOINT [ "composer",  "--ignore-platform-reqs" ]
# eksik bağımlılıklarda hata vermemesi için