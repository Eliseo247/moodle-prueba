FROM ansp/php-73-rhel7:latest
MAINTAINER Joeri van Dooren

USER 0

RUN yum repolist all && \ 
yum-config-manager --enable rhel-7-server-extras-rpms && \
yum-config-manager --enable rhel-7-server-optional-rpms && \
yum-config-manager --enable rhel-server-rhscl-7-rpms && \
yum makecache && \
yum php-xmlrpc.x86_64 -y && \
yum clean all && \
#rm -rf /var/cache/yum/*

#RUN yum -y install php-xmlrpc && yum clean all -y

#ADD moodle.tar.gz /opt/app-root/src/

#RUN tar xvzf /opt/app-root/src/moodle.tar.gz

RUN mkdir /opt/app-root/moodldata
RUN chgrp -R 0 /opt/app-root/moodldata && \
   chmod -R g+rwX /opt/app-root/moodldata


RUN chgrp -R 0 /opt/app-root/src && \
   chmod -R g+rwX /opt/app-root/src
    
#RUN chgrp -R 0 /var/www/html && \
    #chmod -R g+rwX /var/www/html
    
COPY run_wordpress.sh /
#VOLUME /opt/app-root/src

#USER 997
#EXPOSE 8080

CMD ["/bin/bash", "/run_wordpress.sh"]
#RUN exec httpd -D FOREGROUND

# Set labels used in OpenShift to describe the builder images
