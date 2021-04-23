FROM node:15-alpine3.11

WORKDIR /app

COPY . /app

RUN npm install

CMD [ "node", "src/server.js" ]

EXPOSE 3000