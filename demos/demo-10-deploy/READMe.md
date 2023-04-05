# Amazon EC2
- Elastic Compute Cloud

## For linux And Macos
- chmod 400 amazon-demo-1.pem
- sudo ssh -i "amazon-demo-1.pem" ec2-user@ec2-13-48-47-129.eu-north-1.compute.amazonaws.com

- docker kurulumu yapılır.
  - sudo yum update -y
  - sudo yum -y install docker
  - sudo service docker start
  - sudo usermode -a -G docker ec2-user
  - sudo systemctl enable docker

- 2 seçenek var.
  - 1.
    - Proje source kodu uzak sunucuya alınır.
    - build edilir.
    - image run edilir.
  - 2.
    - image kendi makinemizde build edilir 
      - docker build -t huseyin43/node-example-1 .
    - pushlanır
      - docker login
      - docker push huseyin43/node-example-1
    - image uzak sunucuda pull edilir
      - docker pull huseyin43/node-example-1
    - image run çalıştırılır.
      - docker run -d --rm -p 80:80 huseyin43/node-example-1
- Uygulamanın dışarı açılabilmesi için aws network'de değişiklik yapmak gerekir.
  - Ip adresi aws servisde yazmaktadır. IPv4 ip adresi internete açılan adrestir.
  - Inbound ve outbound rules.
  - outbound olan içerden dışarı çıkan isteklerin kuralını belirler.
  - default heryer izinlidir.
  - inbound ise default sadece ssh port'u için dışarı açıktır.
  - Buraya uygulamanın çalıştığı port'u http tipinde eklersek uygulama erişilebilir olur. (::/0 -> for every ip adresses)
- Uygulamanın güncellenmesi için
  - Önce docker pull yapılarak latest versiyonun tekrar çekilmesi gerekir.
  - Daha sonra docker run yapılınca güncel versiyon çalışacaktır.


# Amazon ECS
- Elastic container service

- Burada container çalıştırmak daha doğrudur. Sebebi makinenin güvenliği dahil bir çok iş yükü oluşacaktır.
- Bu servisle birlikte birçok iş yükü olmayacak ve yapmamız gereken işe odaklanabiliriz.
- Bu serviste birçok şey otomatize gerçekleşecektir.
  - creation, management, updating, monitoring and scaling
- Servis 4 adımdan oluşur. (içten dışa doğru)
  - Container Definition
    - container name
    - image url veya adı
    - port mapping
    - health check advange bilgileri
    - resource bilgileri
    - Ayrıca belirtilmekistediğimiz diğer command'leri yazıyoruz.
    - Environment variables
    - Volumes and logging
  - Task Definition
    - Yapılması istenilen ne.
    - Hangi netork
    - Execution bilgisi
  - Service
    - load balance
    - desired task size
  - Cluster
    - Çalışacağı cluster'a dair bilgiler.
- FARGATE (compatibilities) (Task altında)
  - container'a istek geldikçe aktive etmeye yarıyor.