FROM node

# linuxtaki cd komutudur. Belirtilen alana gider.
WORKDIR /app

# 1.path container dışındaki alanı ifade eder.
# 2.path ise container'ın içindeki path'i gösterir.
# 2.path olmasada create olacaktır.
# ./../../ come back demo-2 folder
COPY . /app

RUN npm install

# Uygulama içeride 80 port'unda çalışıyor olacak bu port'u dinle ve çıkış ver.
# run yapan kişi bu port'u ayrıca belirteceği bir port ile yayınlaması gerekir.
# Yani docker imagede uygulamayı alıyor 80 portundan yayınlıyor.
# run komutuda container'ın 80 port'unu bulunulan ortamda yayınlıyor.
EXPOSE 80

# Son run komutu built adımında çalışmaz. run komutu ile bu adım çalışır.
RUN node server.js
# CMD node server.js
# CMD [ "node", "server.js" ]

# docker build -f ./docker/docker-1/Dockerfile .