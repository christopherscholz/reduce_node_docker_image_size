FROM node:19.0.0-bullseye

ADD . /app
WORKDIR /app/react
RUN npm install
RUN npm run build

WORKDIR /app/express
RUN npm install

EXPOSE 3000
CMD ["node", "index.js"]