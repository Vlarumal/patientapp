FROM node:lts-alpine3.20 AS build-prod-stage
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN npm ci
ENV DEBUG=backend_patientapp:*
COPY . .
RUN npm run tsc

FROM build-prod-stage AS backend-prod-stage
RUN apk add --no-cache tini
ENV NODE_ENV=production
WORKDIR /usr/src/app
# COPY --chown=node:node package*.json ./
# RUN npm ci --only=production && npm cache clean --force
COPY --from=build-prod-stage --chown=node:node /usr/src/app ./
RUN npm prune --production
USER node
ENTRYPOINT [ "/sbin/tini", "--"]
CMD ["npm", "start", "--", "--host"]
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["wget", "-q", "--spider", "http://localhost:3001/api/ping"]