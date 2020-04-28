#FROM registry.access.redhat.com/rhel7/rhel:latest
FROM ansp/php-73-rhel7:latest
MAINTAINER Josue Ramirez
USER 0
RUN mkdir /opt/app-root/moodledata
RUN chgrp -R 0 /opt/app-root/moodldata && \
   chmod -R g+rwX /opt/app-root/moodldata
COPY run_wordpress.sh /
VOLUME /opt/app-root/src

RUN export USER_ID=$(id -u)
RUN export GROUP_ID=$(id -g)
RUN envsubst < ${HOME}/passwd.template > /tmp/passwd
RUN export LD_PRELOAD=/usr/lib64/libnss_wrapper.so
RUN export NSS_WRAPPER_PASSWD=/tmp/passwd
RUN export NSS_WRAPPER_GROUP=/etc/group


RUN yum -y install nss_wrapper gettext

USER 1001
#EXPOSE 8080
CMD ["/bin/bash", "/run_wordpress.sh"]
