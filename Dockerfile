FROM node:18-alpine AS builder

WORKDIR /Devops-assignment

ARG REACT_APP_ENVIRONMENT

ENV REACT_APP_ENVIRONMENT=${REACT_APP_ENVIRONMENT}

COPY package.json ./
COPY package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:alpine

WORKDIR /Devops-assignment

RUN npm install -g serve

COPY --from=builder /Devops-assignment/build ./build




EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]
