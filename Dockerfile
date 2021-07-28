FROM php:7-fpm-alpine

ARG RELEASE

WORKDIR /
RUN apk add --no-cache sqlite nginx supervisor msmtp

# BAIKAL
RUN wget https://github.com/sabre-io/Baikal/releases/download/$RELEASE/baikal-$RELEASE.zip -O baikal.zip && unzip baikal.zip && rm baikal.zip && mv baikal app
RUN chown -R www-data:www-data app

# COPY CONFS
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./nginx.conf /etc/nginx/http.d/default.conf

# NGINX FIX
RUN mkdir -p /run/nginx && chown -R nginx:nginx /run/nginx

# START
COPY ./start.sh ./start.sh

# DOCKER SETTINGS
VOLUME [ "/app/config", "/app/Specific/db" ]
EXPOSE 8080

CMD ["./start.sh"]
