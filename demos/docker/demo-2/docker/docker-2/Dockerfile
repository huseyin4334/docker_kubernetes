FROM node

WORKDIR /app

# Bu kullanımda cache mekanizmasının daha efektif kullanılabilmesi için 
# package.json dosyasında bir değişim olmadığı müddetçe npm install komutunun
# çalıştırılmaması ve cacheten getirilmesi sağlanacaktır.

# Çünkü cache değişimin olduğu yerden itibaren sonraki layer'ların tamamında cache'den çıkar.
COPY package.json /app

RUN npm install

# node_modules oluştuktan sonra kod içeriklerini içeri alıyoruz.
COPY . /app

EXPOSE 80

RUN node server.js

# docker build -f ./docker/docker-2/Dockerfile .