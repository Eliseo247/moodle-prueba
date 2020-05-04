 
FROM php-73-rhel7:latest  
MAINTAINER Eliseo RAMIREZ
USER root
RUN yum -y install cronie
ADD crontab /etc/crontab
ADD 0hourly /etc/cron.d/0hourly
COPY entrypoint /entrypoint

ADD https://download.moodle.org/stable38/moodle-latest-38.tgz /
RUN chmod a+rw /moodle-latest-38.tgz

RUN mkdir /opt/app-root/moodledata
RUN chmod 775 /opt/app-root/moodledata
RUN chmod 775 /opt/app-root/src
RUN touch /etc/crontab /etc/cron.*/*
ADD php.ini /opt/app-root/etc/php.ini
COPY run_moodle.sh /

VOLUME /opt/app-root/moodledata
USER 1000250000
EXPOSE 8080

ENTRYPOINT ["/entrypoint"]
CMD ["/bin/bash","/run_moodle.sh"]



# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Wordpress" \
      io.k8s.display-name="wordpress apache centos7 epel" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,wordpress,apache" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
