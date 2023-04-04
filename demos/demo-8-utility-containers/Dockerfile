FROM node:14-alpine

WORKDIR /app

# image adından sonra verilen komut burada çalıştırıldığı için. entry point ile komutu sınırlayabiliyoruz.
# Yani kişi sadece npm komutu çalıştırabilir.
# docker run -v "..../docker_kubernetes/demos/demo-8-utility-containers:/app" -it try init
ENTRYPOINT [ "npm" ] 

# Böylece ana makinemize bağımlılıkları kurmasakta proje create ettik.
# docker build .
# docker run -it
# docker run -v "..../docker_kubernetes/demos/demo-8-utility-containers:/app" -it try npm init