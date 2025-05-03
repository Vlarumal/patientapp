FROM node:lts-alpine3.20 AS frontend-dev-stage
RUN apk add --no-cache tini
WORKDIR /usr/src/app
ENV NODE_ENV=development
ENV VITE_API_BASE_URL=http://localhost:8081/api/api
COPY package*.json ./
RUN npm install
COPY . .
ENTRYPOINT [ "/sbin/tini", "--"]
CMD ["npm", "run", "dev", "--", "--host"]