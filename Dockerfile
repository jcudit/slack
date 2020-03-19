FROM node:10

WORKDIR /app
COPY . /app

ENV NODE_ENV development
ENV DB_USERNAME_TEST "postgres"
ENV DB_HOST_TEST "postgresql"

RUN npm install

CMD ["script/server"]
