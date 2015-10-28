FROM lucee/lucee4-nginx:latest

MAINTAINER Geoff Bowers <modius@daemon.com.au>

# Tomcat configs
# COPY catalina.properties server.xml web.xml /usr/local/tomcat/conf/
# Custom setenv.sh to load Lucee
# COPY setenv.sh /usr/local/tomcat/bin/

# NGINX configs
COPY config/nginx/ /etc/nginx/

# Lucee server PRODUCTION configs
COPY config/lucee/lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

# Deploy codebase to container
COPY code /var/www