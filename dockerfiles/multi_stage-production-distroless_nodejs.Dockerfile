FROM node:19.0.0-alpine3.16 as builder

ADD . /app
WORKDIR /app/react
RUN npm install
RUN npm run build

ENV NODE_ENV=production
WORKDIR /app/express
RUN npm install


FROM gcr.io/distroless/nodejs18-debian11

COPY --from=builder /app/react/build /app/react/build
COPY --from=builder /app/express /app/express

WORKDIR /app/express
EXPOSE 3000
CMD ["index.js"]