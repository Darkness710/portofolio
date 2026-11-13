
ARG NODE_VERSION=24

FROM node:${NODE_VERSION}-bookworm-slim

WORKDIR /app

COPY package*.json ./

RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

COPY . .

EXPOSE 4321

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
