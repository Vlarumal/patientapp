FROM node:lts-alpine3.20 AS backend-dev-stage
RUN apk add --no-cache tini
ENV NODE_ENV=development
ENV DEBUG=backend_patientapp:*
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
ENTRYPOINT [ "/sbin/tini", "--"]
CMD ["npm", "run", "dev", "--", "--host"]