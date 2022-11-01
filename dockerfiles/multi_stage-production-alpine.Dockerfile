FROM node:19.0.0-alpine3.16 as builder

ADD . /app
WORKDIR /app/react
RUN npm install
RUN npm run build


FROM node:19.0.0-alpine3.16 as runner
ENV NODE_ENV=production

ADD ./express /app/express
COPY --from=builder /app/react/build /app/react/build

WORKDIR /app/express
RUN npm install

EXPOSE 3000
CMD ["node", "index.js"]