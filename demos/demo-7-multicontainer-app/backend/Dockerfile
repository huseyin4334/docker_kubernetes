FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

ENV mongo_username=root
ENV mongo_password=secret

CMD [ "npm", "start" ]

# docker run --name mongodb -d --network demo-7-network --rm -e MONGO_INITDB_ROOT_USERNAME=huseyin -e MONGO_INITDB_ROOT_PASSWORD=huseyin -v mongo-data:/data/db mongo
# docker build -t demo-7-backend -f .\Dockerfile .
# docker run -d --name demo-7-backend-c -p 80:80 --network demo-7-network -v /app/node_modules -v backend-logs:/app/logs --rm demo-7-backend