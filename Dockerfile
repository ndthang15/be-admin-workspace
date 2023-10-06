FROM node:16-alpine

WORKDIR /app

# ARG GITHUB_ACCESS_TOKEN
RUN apk update
RUN apk add git curl
# RUN git config --global url."https://${GITHUB_ACCESS_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"

COPY package.json /app
COPY package-lock.json /app

RUN npm install

COPY . /app

EXPOSE 6303


CMD ["node", "server.js"]