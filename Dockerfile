FROM alpine:latest

LABEL maintainer="Manuel Laug <laugmanuel@gmail.com>"
LABEL name="laugmanuel/grav"

RUN addgroup -g 555 -S nginx \
    && adduser -SD -u 555 -h /usr/share/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && apk --no-cache add curl \
         ruby \
         ruby-json \
         jq \
         nginx \
         php7 \
         php7-fpm \
         php7-curl \
         php7-ctype \
         php7-dom \
         php7-gd \
         php7-json \
         php7-mbstring \
         php7-openssl \
         php7-pecl-redis \
         php7-pecl-yaml \
         php7-session \
         php7-simplexml \
         php7-xml \
         php7-zip \
    && mkdir -p /grav /usr/share/nginx/html \
    && chown nginx:nginx /grav /usr/share/nginx/html

RUN GRAV_VERSION=$(curl -sq https://api.github.com/repos/getgrav/grav/releases/latest | jq -r '.tag_name') \
    && curl -L --output /grav/grav-v${GRAV_VERSION}.zip https://github.com/getgrav/grav/releases/download/${GRAV_VERSION}/grav-v${GRAV_VERSION}.zip \
    && unzip -d /grav /grav/grav-v${GRAV_VERSION}.zip \
    && rm -rf /etc/nginx/conf.d && mkdir /etc/nginx/conf.d

COPY root/ /

WORKDIR /usr/share/nginx/html

EXPOSE 8080

CMD ["/docker-init.sh"]
