# Stage 1
FROM node:18-alpine AS build
WORKDIR /app


COPY src/web-frontend/package*.json ./
RUN npm install

COPY src/web-frontend/ .


RUN npm run build

# Stage 2
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80