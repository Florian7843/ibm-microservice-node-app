FROM node:alpine

WORKDIR /app

COPY . /app

RUN npm install && \
  apk update && \
  apk upgrade

EXPOSE 3000

CMD [ "npm", "start" ] 