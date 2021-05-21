FROM php:7-fpm-alpine

ARG RELEASE

WORKDIR /
RUN apk add --no-cache sqlite nginx
RUN wget https://github.com/sabre-io/Baikal/releases/download/$RELEASE/baikal-$RELEASE.zip -O baikal.zip && unzip baikal.zip && rm baikal.zip && mv baikal app
RUN chown -R www-data:www-data app

RUN mkdir -p /run/nginx
RUN echo "nginx && php-fpm" > start.sh
RUN chmod +x start.sh
COPY ./nginx.conf /etc/nginx/http.d/default.conf

VOLUME [ "/app/config", "/app/Specific/db" ]
EXPOSE 8080

CMD ["./start.sh"]
