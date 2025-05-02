FROM node:lts-alpine3.20 AS base-stage
WORKDIR /usr/src/app

ARG VITE_API_BASE_URL=http://localhost:80/api
ENV VITE_API_BASE_URL=${VITE_API_BASE_URL}

FROM base-stage AS dependencies-stage
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci

FROM dependencies-stage AS test-stage
COPY . .
# RUN npm run test

FROM test-stage AS build-stage
RUN npm run build

FROM nginx:stable-alpine3.20-slim AS patientapp-frontend-prod
ENV NODE_ENV=production
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf