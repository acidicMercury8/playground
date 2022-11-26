FROM node:18-alpine

WORKDIR /app
ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=password
EXPOSE 3000

COPY package*.json ./
RUN npm install

COPY . .
CMD [ "node", "index.js" ]
