# ================second variant====================
# stage 1 - react app 
FROM node:lts AS builder
# Встановити робочий каталог 
WORKDIR /app
# Скопіюйте файли package.json і package-lock.json 
COPY package*.json ./
# Встановити залежності 
RUN npm install
# Скопіюйте файли програми 
COPY . .
# Збілдити проєкт in folder build
RUN npm run build

# stage 2 Working image - for run in containar
FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html
# Відкрити порт 
EXPOSE 80
# Запустіть програму: гарантує , що nginx залишиться "на передньому плані" для правильного відслудкування процесів docker
CMD ["nginx", "-g", "daemon off;"]




# FROM node:20-alpine
# WORKDIR /react-docker-test/
# COPY package.json  /react-docker-test/
# RUN npm install
# COPY public/ /react-docker-test/public
# COPY src/   /react-docker-test/src
# # RUN npm run build

# CMD [ "npm","start" ]


# FROM node:lts as builder
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build
# CMD [ "npm","start" ]
