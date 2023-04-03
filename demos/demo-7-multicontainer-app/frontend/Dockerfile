FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]

# Çok Önemli react browser üzerinde kodu çalıştırdığı için container name ile istekler çalışmaz.
# react app'in backend'i bulabilmesi için locale port açıp oradan erişim vermeliyiz.
# docker build -t demo-7-frontend -f .\Dockerfile .
# docker run -d --name demo-7-frontend-c -p 3000:3000 --network demo-7-network -v "/User/../frontend/src:/app/src:ro" -v /app/node_modules --rm demo-7-frontend