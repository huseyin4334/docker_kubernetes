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

docker <span style="color:orange"> run -it \<image></span>
docker <span style="color:orange"> exec -it \<container> sh</span>
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

### Managing Data & Working With Volumes
- Container silinmediği müddetçe volume mapping yapılmamış dosyalar silinmez.
- Ancak konteynır silinmişse dosyalar uçar ve create olmuş dosyalar silinir.
- Ancak bu dosyalar bize lazımsa volume mapping yapmak gerekir.
- Volume çalışılan ortamda belirtilen yere kaydedilir. 
- Image'de belirtilen yere bakılır ve volume dosyaları varsa konteynıra alınır.

#### Volume Types
- 2 tip volume mapping var.
- Bind Mounts
  - Managed by ourself
- Volumes
  - Managed by docker
  - Anonymous Volumes
  - Named Volumes

##### Volumes
- Docker bu kalıcı dosyalamayı yönetir. Nerede olduğunu bilmeyiz.

docker <span style="color:orange">volumes</span>

docker volumes <span style="color:orange">--help</span>

create, ls, ps, inspect, rm, prune

docker volumes <span style="color:orange">create feedback-files</span>

inspect yaptığımızda Mountpoint ile gösterilen path docker'ın host makinede kurduğu sanal ortamın path'idir.(Linux değilse)

##### Bind Mounts
- Bind mounts dinamik değişkenlik gösteren kalıcı verilerin image'e gösterilmesinde ve kullanılmasında çok işe yarar.
- Volumu docker tarafından kontrol edilirken bind mount kendimiz tarafından kontrol edilir.


### Environment Variables And Arguments
- Bu 2'sini ayıran özellik birinin build timeda birininde runtimeda çalışmasıdır.
- ARG
  - Build time argument
  - Dockerfile içinde
    - ARG şeklinde yazılır.
  - Komutla değeri verirken
    - --build-args
- ENV
  - Runtime environment variable
  - Dockerfile içinde
    - ENV şeklinde yazılır.
  - Komutla değeri verirken
    - --env


### NETWORKS IN DOCKER
- 3 senaryomuz var
  - www'ya istekte bulunma.
    - Global requestler container applerden dışarı yapılabilmektedir.
  - host makinede çalışan uygulamaya istekte bulunma
    - localde çalışan container olmayan app'e direk localhost:../... şeklinde istek atılmaya kalkılırsa erişim sağlanamaz.
    - Bu tür durumlarda docker'ın container içersinide host makinesinin ip adresini bilmesi için bir değer vardır. <span style="color:orange">host.docker.internal</span>
    - Dönüşüm şu şekilde olacaktır;
      - http://localhost:27017/......
      - http://host.docker.internal:27017/.....
    - Böylece istek host makinesine gidecektir.
  - başka bir container'a istekte bulunma
    - Burada docker, container için bir internal ip adresi vermektedir.
    - docker container inspect ....
    - Buradaki ip adresini koda yazarak erişim sağlanabilir.
    - Ancak her yeni containerda bu ip adresi değişeceğinden verimli bir çözüm yöntemi değildir.
    - O sebeple diğer bir çözüm yönetimide container'ın adını kullanmaktır. Bu daha sabit bir değer sağlar. Tabi bunu yapabilmek için container'ların aynı network altında olması gerekmektedir.
    - http://172.0.1.12:27017/.....
    - http://mongodb:27017/.....

#### Network Management

docker run <span style="color:orange">--network my_network</span>

> Proje kodunda url'de isteği container'ın adı ile belirtmek için bu 2 container'ında aynı ağ içerisinde olması gerekir.

> Ayrıca sadece içerde kullanılan ve dışarıdan erişime ihtiyacın olmadığı container'lar için -p ile port mapping yapmaya ihtiyaç yoktur.


Network Creation
- Docker network'ü volume gibi otomatik oluşturmaz. Bu sebeple kullanmadan önce create etmek gerekir.
- docker network --help
- docker network create \<network-name>
- docker create --driver bridge \<network-name>

Docker also supports these alternative drivers - though you will use the "bridge" driver in most cases:

- **host:** For standalone containers, isolation between container and host system is removed (i.e. they share localhost as a network)

- **overlay:** Multiple Docker daemons (i.e. Docker running on different machines) are able to connect with each other. Only works in "Swarm" mode which is a dated / almost deprecated way of connecting multiple containers

- **macvlan:** You can set a custom MAC address to a container - this address can then be used for communication with that container

- **none:** All networking is disabled.

Third-party plugins: You can install third-party plugins which then may add all kinds of behaviors and functionalities

As mentioned, the "bridge" driver makes most sense in the vast majority of scenarios.

### Docker Compose
- Docker compose tek bir konfigürasyon dosyasıyla ve aynı makinede birden fazla container'ı manage etmek için iyi bir araçtır.
- Docker compose dockerfile yerine geçmez dockerfile'ı kullanır.
- Docker compose'da container'lar servis olarak isimlendirilir.

docker compose up
- up olduğunda prefix olarak projenin dosya ismini kullanır.
- bir network oluşturur.
- volume varsa onu create eder.
- default olarak attach modda başlar.
  - docker-compose up -d ile mod değişebilir.

docker compose down
- komutu çalıştığında volume hariç, image, network gibi diğer şeyleri silecektir.
- Yani otomatik bir şekilde --rm ile gelmektedir.

### Utility Containers
- docker <span style="color:orange">exec</span>
- Uygulama çalışmaya devam ederken container üzerinde kod çalıştırmamızı sağlar
- Örneğin
  - docker run -it -d node
  - docker exec \<container> npm init
  - docker exec [options] container [console_command]


## Kubernetes
- 2 types nodes in kubernetes
  - Master Node
    - Altında worker node'ların kontrolünü sağlamak için bir çok tool vardır.
  - Worker Node
    - 2 thing in this node
    - Proxy/config
      - That's here for communication configuration.
      - Container communicate and reachable from internet with this module 
    - Pod
      - Containers and volumes in here working.
      - So here is container virtual environment.
      - 1 container suggested.
- It's called Cluster.

### Worker Node
- Pod
  - containers
  - Volumes
  - Container Orchestration tool (Docker)
  - Kubelet
    - Communication between master and worker node
  - Kube proxy
    - Incoming and outgoing network traffic everythig working desired.

# Master Node
- API Server
  - API Server communicat with kubelet
- Scheduler
  - That's control nodes for pods. Pod health check, recreate, create, scaling and so on.
  - It's working with API server
-  Kube controller manager
   -  Watches and controls worker nodes, correct number of pods and more.
   -  It's working with scheduler
-  Cloud controller manager
   -  That's knows how to interact with Interact with Cloud provider resources