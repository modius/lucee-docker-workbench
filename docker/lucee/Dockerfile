FROM lucee/lucee-nginx:latest

MAINTAINER Geoff Bowers <modius@daemon.com.au>

COPY nginx/ /etc/nginx/
COPY lucee/ /opt/lucee/web/

RUN apt-get update && apt-get -y autoremove && apt-get install -y git-core
RUN rm -rf /var/www/*
RUN git clone -b master --single-branch https://github.com/modius/lucee4-website.git /var/www