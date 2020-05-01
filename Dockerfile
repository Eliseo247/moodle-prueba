 
FROM php-73-rhel7:latest  
MAINTAINER Eliseo RAMIREZ
USER root

RUN yum install -y cronie && yum clean all
RUN crontab -l | { cat; echo "* * * * * root php  /opt/app-root/src/admin/cli/cron.php "; } | crontab -


# comment out PAM

#RUN touch /var/log/cron.log
# Setup cron job
#RUN (crontab -l ; echo "* * * * * echo "Hello world" >> /var/log/cron.log") | crontab
#* * * * * /usr/bin/php  /opt/app-root/src/admin/cli/cron.php >/dev/null

#ADD crontab /etc/
#ADD 0hourly /etc/cron.d/
#ADD my-script.sh /usr/local/bin/

#ADD https://download.moodle.org/stable38/moodle-latest-38.tgz /
#RUN chmod a+rw /moodle-latest-38.tgz

RUN mkdir /opt/app-root/moodledata
RUN chmod 775 /opt/app-root/moodledata
RUN chmod 775 /opt/app-root/src

#ADD runcron /usr/local/bin/runcron  && chmod u+x runcron

ADD php.ini /opt/app-root/etc/php.ini
COPY run_moodle.sh /
###############################################################################
RUN chmod a+rw /etc/passwd

VOLUME /opt/app-root/moodledata

#/opt/app-root/src/admin/cli/cron.php
#USER 997
#USER 1001
EXPOSE 8080
#CMD ["cron", "-f"]
# Run the command on container startup
#CMD cron && tail -f /var/log/cron.log

CMD ["/usr/sbin/init"]
CMD ["/bin/bash","/run_moodle.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Wordpress" \
      io.k8s.display-name="wordpress apache centos7 epel" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,wordpress,apache" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
