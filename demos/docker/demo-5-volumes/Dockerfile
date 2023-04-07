FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# PORT WITH ENVIRONMENT VARIABLE OR ARGUMENT 

# Container çalışacağı sıra hangi port ile açılacağını dinamik olarak
# belirtebilmiş olduk.
# Değeri değiştirmek için;
# docker run -p 3000:8000 --ENV PORT=8000
# Dosya ile belirtmek içinde .env kullanılır. Örneğin (.env var kabul edersek);
# docker run -p 3000:8000 --env-file ./.env
ENV PORT=80
# Veya ENV PORT 80

# ARG DEFAULT_PORT=80
# ENV PORT=$DEFAULT_PORT
# ayrıca yapılabilir.
# docker build --build-args DEFAULT_PORT=8000 .

EXPOSE $PORT

# VOLUMES ----------------------------------------------------------
# 1.path container içindeki pathdir.
# Bu şekilde kullandığımızda anonim volume oluşur ve yalnızca bu konteynıra
# özel volume saklanır ve bu konteynır silindiğinde bu volumeda silinir.
# Volume'u isimlendirerek mapping'in kaybolmasını önleyebiliriz.
# Bu isimlendirme dockerfile içinde yapılamamaktadır. (Named volume)
# Named volume
#   docker run .... -v feedback:/app/feedback (volume_name:path)
# Anonymous volume
#   VOLUME [ "/app/feedback" ]


# BIND MOUNTS -------------------------------------------------------
# -v User/..../demo-5-volumes:/app
# -v "User/..../demo-5-volumes:/app" (Eğer boşluk gibi şeyler varsa bu şekilde yazılabilir.)
# -v $(pwd):/app -> linux or mac
# -v "%cd%":/app -> windows
# docker host makinede belirtilen yeri container içindeki klasöre bağlar.
# Dikkat edilmesi gereken docker'ın bu klasöre erişim izninin olmasıdır.
# Docker destop > Resources > File Sharing'den kontrol edilebilir.
# bind mount yapıldığında bu dosyalar container içinde barındırılmaz container
# dosyanın bulunduğu yerden beslenir.


# WARNING ---
# Ancak image hazırlandıktan sonra mount işlemi gerçekleştiği için 
# container içinde önceden oluşmuş tüm dosyalar uçmuş olacak.
# Bunu önlemenin yolu anonymous volume mapping yapmaktır.
# Çünkü çakışma durumlarında docker daha içte bulunan dosya yolunun 
# volume mappingini kabul eder ve o bilgiyi ezmez.
# -v User/..../demo-5-volumes:/app -v /app/node_modules
# Yukarıdaki örnekteki gibi docker node_modules'ü ezmeyi bırakacaktır.
# volume isimlendirilmediği için anonymous kabul edilir.
# -v /app/node_modules -> VOLUME [ "/app/feedback" ]
# Birde bind mount'da container'dan host makineye yazmak yoktur.

# Değişikilklerin container'a yansıması PART - 1
# node js'de değişikliğin gelmesi için docker stop and docker start
# yapılabilir.
# CMD [ "node", "server.js" ]


# Değişikilklerin container'a yansıması PART - 2
# (Windows için ek birşeyler yapmak gerekiyor)
# nodemon eklentisi konuldu ve script olarak node server.js eklendi.
# Burada yapmamız gereken 
CMD [ "npm", "start" ]
# Artık nodemon bir değişiklik olunca server'ı yeniden çalıştıracak.


# READ ONLY
# -v User/..../demo-5-volumes:/app:ro
