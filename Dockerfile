# Build state
FROM node:20 AS development
WORKDIR /react-app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Run state
FROM nginx:alpine AS production
COPY --from=development /react-app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
