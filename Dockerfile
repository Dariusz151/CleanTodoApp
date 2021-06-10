FROM node as builder

COPY ./clean-todo-app-ui/package.json ./
RUN npm install 
WORKDIR /app
COPY ./clean-todo-app-ui .

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY docker/nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]