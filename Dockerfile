#FROM registry.access.redhat.com/rhel7/rhel:latest
FROM ansp/php-73-rhel7:latest
MAINTAINER Joeri van Dooren

USER 0

#RUN subscription-manager attach --pool=8a85f98c635f699f016374b1eabb0c06
#RUN subscription-manager repos --enable=rhel-server-rhscl-7-rpms 
#RUN yum -y install httpd24-httpd
#RUN yum -y install rh-php70

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
