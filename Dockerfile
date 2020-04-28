FROM ansp/php-73-rhel7:latest
MAINTAINER Joeri van Dooren

USER 0

RUN yum -y install vim && yum clean all -y

#ADD http://wordpress.org/latest.tar.gz /opt/app-root/src/

#RUN tar xvzf /opt/app-root/src/latest.tar.gz

#RUN mkdir /opt/app-root/moodldata2

#RUN chgrp -R 0 /opt/app-root/src && \
   # chmod -R g+rwX /opt/app-root/src
    
#RUN chgrp -R 0 /var/www/html && \
    #chmod -R g+rwX /var/www/html
    
#COPY run_wordpress.sh /
#VOLUME /opt/app-root/src

#USER 997
#EXPOSE 8080
#CMD ["/bin/bash", "/run_wordpress.sh"]
#RUN exec httpd -D FOREGROUND

# Set labels used in OpenShift to describe the builder images
