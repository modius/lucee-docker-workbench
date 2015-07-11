FROM lucee/lucee-nginx:latest

MAINTAINER Geoff Bowers <modius@daemon.com.au>

# Tomcat configs
# COPY catalina.properties server.xml web.xml /usr/local/tomcat/conf/
# Custom setenv.sh to load Lucee
# COPY setenv.sh /usr/local/tomcat/bin/

# NGINX configs
COPY nginx/ /etc/nginx/
# Lucee server configs
COPY lucee/ /opt/lucee/web/

# Deploy codebase to container
RUN apt-get update && apt-get -y autoremove && apt-get install -y git-core
RUN rm -rf /var/www/*
RUN git clone -b master --single-branch https://github.com/modius/lucee4-website.git /var/www