FROM boomfish/lucee-nginx:4.5

MAINTAINER Geoff Bowers <modius@daemon.com.au>

COPY nginx/ /etc/nginx/
COPY lucee/ /opt/lucee/web/

RUN git clone -b master --single-branch https://github.com/modius/lucee4-website.git /var/www