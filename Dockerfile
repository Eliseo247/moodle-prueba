 
FROM php-73-rhel7:latest  
MAINTAINER Eliseo RAMIREZ
USER root
ADD https://download.moodle.org/stable38/moodle-latest-38.tgz /
RUN chmod a+rw /moodle-latest-38.tgz


RUN chmod a+rw /moodle-latest-38.tgz
COPY run_moodle.sh /

RUN mkdir /opt/app-root/moodledata
RUN chmod 775 /opt/app-root/moodledata
RUN chmod 775 /opt/app-roo/src

VOLUME /opt/app-root/src

USER 1001
EXPOSE 8080
CMD ["/bin/bash", "/run_moodle.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Wordpress" \
      io.k8s.display-name="wordpress apache centos7 epel" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,wordpress,apache" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
