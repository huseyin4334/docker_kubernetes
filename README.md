# Docker And Kubernetes The Pratical Guide

> Content: https://demy.com/course/docker-kubernetes-the-practical-guide/


## Docker

We are using docker for encapsulate to application. Docker lighter than virtual machines.

![Virtual Machine Design](./sources/images/virtual_machine.png)

![Docker Design](./sources/images/docker_system.png)

- Docker playground: https://labs.play-with-docker.com

- Docker linux hariç diğer işletim sistemlerinde sanallaştırma kullanır. 
- Base olarak linux vardır. Windowsta bu wsl2 veya hyper-v ile yapılır. 
- Bunu indirdiğimiz docker desktop yönetir.
- Bu sanallaştırmanın üzerinde ise <span style="color:orange;">docker engine</span> çalışır.


### Images And Containers
- Containers are unit of software
- Images are templates/blueprints for containers

#### Images
- Image'i oluşturmak için dahi base bir image'e ihtiyacımız vardır.
- Image bir template'dir. 
- Çalıştırma komutu geldiğinde template localde yoksa indirilir ve template docker tarafından dockerfile'da tanımlanmış son yürütme komutu ile container olarak çalışır yapıya dönüşür.
- Image read only bir yapıdır.
- Dışarıdan değişiklik yapılamaz.


### Docker In Practice
- docker pull \<image name>
- docker run <span style="color:orange">-p 3000:3000</span> \<id or name>
  - (publish) \<external port>:\<internal port>
  - Bulunulan ortamda belirtilen portta container'ın belirtilen port'unu yayınla.
- docker <span style="color:orange">images</span>
- docker <span style="color:orange">ps</span> 
  - (process)
- docker ps -a 
  - (get run or stopped containers)
- docker run <span style="color:orange">-it</span> node
  - (interactive terminal)
  - Çalışan konteynırda bir terminal açayı sağlar.
- docker <span style="color:orange">build</span> .
  - \<.> dockerfile'ın yerini belirtir.
- docker <span style="color:orange">stop</span>
  - container'ın çalışmasını durdur.
- docker <span style="color:orange">start</span>


### LAYER BASE IMAGES
- Her satır bir layerdır. Layerlar cachelenir. Eğer docker çalıştırılan layer'ın cache'ine sahipse ve bir değişime uğramamışsa layer'ı cache'den getirir.


### Managing Image And Container
- Image
  - docker tag
    - tagged an image
  - docker images
    - listed
  - docker image inspect
    - analyzed image
  - docker rmi
    - delete
  - docker prune
    - delete
- Container
  - docker --name
  - docker --help
  - docker ps
  - docker rm

Run command details

docker run 
<span style="color:orange">-a / attach</span>
<span style="color:orange">-d / detach</span> 
- (attach mode) -> default detach mode'dur (-d)
- attach mode console'u dinler.
- detach mode sadece id değeri döner. Uygulama arka planda çalışır.

<span style="color:orange">-t/--name myName</span>
- (tagged)
- uygulamanın adını belirlemiş oluruz.

<span style="color:orange">-p 8080:8080</span>
-  port ataması yapılır.

<span style="color:orange">--rm</span>
- eğer container exit statüsüne geçerse container silinir.

<span style="color:orange">name:tag</span>


docker build
<span style="color:orange">-f \<Dockerfile_path></span>

<span style="color:orange">.</span>
- docker build işlemini başlattığında dış dosya konumu olarak gösterilecek yer.

<span style="color:orange">-t name:tag</span>
- name repository yerine kaydedilir.
  - Örneğin
    - ubuntu repodur. Tagleri ile istenilen versiyon çekilebilir.
- tag ise version'u belirtir.
  - latest belirtilirse sadece isimle çalıştırmalarda bu image çekilir.
  - latest default tagdir.(run komutu için)
  - Belirtilmez ise null yazılır.

<span style="color:orange">-a / attach</span>


####Others
docker <span style="color:orange">logs</span>
- anlık logları basar

docker logs <span style="color:orange">-f</span>
- loglar takibini devam ettirir.

docker <span style="color:orange">attach \<container></span>
- detach mode'da çalışan container'ı attach mode'a alır.

docker <span style="color:orange">-it \<container></span>
- interaktif bir terminal açar.
- run komutu ilede kullanılabilir.


docker <span style="color:orange">rm \<container></span>
- delete container or containers

docker <span style="color:orange">rm $(docker ps -a)</span>
- delete all containers

docker <span style="color:orange">rmi \<image></span>
- delete image or images

docker <span style="color:orange">image prune</span>
- delete all unuse images

docker <span style="color:orange">image inspect \<image></span>
- Image hakkında detaylı bilgiler içerir.
- Image layerlar create detayları.
- Architecture bilgileri
- Port bilgileri
- gibi gibi....

docker <span style="color:orange">cp \<out_source_path> \<container_name:container_path></span>
docker <span style="color:orange">cp \<container_name:container_path> \<out_source_path> </span>
- container dışından konteynır içerisine veya tam tersi olacak şekilde kopyalama işlemi yapar.
- Örneğin
  - docker cp dummy/test.txt boring_vaughan:/test
  - log kayıtlarını local makinemize çıkarabiliriz.


## Image Pull And Push
- Aşağıdaki gibi işlemleri yaparsak image default registry olan docker hub'a gider.
  - docker login
  - docker push image_name:tag
  - docker pull image_name:tag

- Aşağıdaki gibi işlemleri yaparsak image login olunan image registry repo'suna gider
  - docker login \<private_registry>
  - docker push \<image_repo_address>/image_name:tag
  - docker pull \<image_repo_address>/image_name:tag

docker tag \<old_name>:tag \<new_name>:tag

- push işleminde base image push olmaz. Extra işlemler pushlanır.
- pull işleminde login olunmamış olursa otomatik docker hub'a bakılır.