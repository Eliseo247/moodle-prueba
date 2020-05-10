FROM php-73-rhel7:latest  
MAINTAINER Eliseo Ramirez

USER root
RUN yum -y install cronie
RUN yum -y install php-xmlrpc-c
RUN mkdir /opt/app-root/moodledata
RUN chmod 775 /opt/app-root/moodledata
RUN chmod 775 /opt/app-root/src
ADD php.ini /opt/app-root/etc/php.ini
COPY run_moodle.sh /

VOLUME /opt/app-root/moodledata
USER 907
EXPOSE 8080

CMD ["/bin/bash","/run_moodle.sh"]
# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="moodle" \
      io.k8s.display-name="moodle apache redhat " \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,moodle,apache" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="2" \
      io.openshift.non-scalable="false"
