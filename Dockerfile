FROM node:15-alpine3.11

WORKDIR /app

COPY . /app

RUN npm install && npm run build

CMD [ "node", "dist/src/server.js" ]

EXPOSE 3000