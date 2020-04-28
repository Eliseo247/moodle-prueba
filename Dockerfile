#FROM registry.access.redhat.com/rhel7/rhel:latest
FROM ansp/php-73-rhel7:latest
MAINTAINER Josue Ramirez
USER 0

VOLUME /opt/app-root/src

RUN mkdir /opt/app-root/moodledata
RUN chgrp -R 0 /opt/app-root/moodledata && \
   chmod -R g+rwX /opt/app-root/moodledata
   
RUN chgrp -R 0 /opt/app-root/src && \
   chmod -R g+rwX /opt/app-root/src

COPY php-xmlrpc-5.4.16-48.el7.x86_64.rpm /opt/app-root/src   
COPY passwd.template /opt/app-root/src
COPY run_wordpress.sh /


RUN export USER_ID=$(id -u)
RUN export GROUP_ID=$(id -g)
RUN envsubst < ${HOME}/passwd.template > /tmp/passwd
RUN export LD_PRELOAD=/usr/lib64/libnss_wrapper.so
RUN export NSS_WRAPPER_PASSWD=/tmp/passwd
RUN export NSS_WRAPPER_GROUP=/etc/group
RUN yum -y install nss_wrapper gettext

USER root
#EXPOSE 8080
CMD ["/bin/bash", "/run_wordpress.sh"]
