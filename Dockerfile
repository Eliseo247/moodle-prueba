FROM registry.redhat.io/ubi7/ubi

RUN yum -y install --disableplugin=subscription-manager \
  httpd24 rh-php72 rh-php72-php \
  && yum --disableplugin=subscription-manager clean all

#ADD index.php /opt/rh/httpd24/root/var/www/html

RUN sed -i 's/Listen 80/Listen 8080/' \
  /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf \
  && chgrp -R 0 /var/log/httpd24 /opt/rh/httpd24/root/var/run/httpd \
  && chmod -R g=u /var/log/httpd24 /opt/rh/httpd24/root/var/run/httpd


ADD moodle.tar.gz /moodle/
RUN mkdir /var/www/moodledata
COPY httpd.conf / 
COPY run_wordpress.sh /
COPY config.php /
#COPY ssmtp /etc/ssmtp
COPY php.ini /etc/opt/remi/php70/php.ini
#UN rm -fr /run/httpd; ln -sf /tmp/run/httpd /run/httpd


VOLUME /var/www/html


RUN chmod a+rw /etc/passwd
#RUN chmod a+rw /etc/ssmtp
RUN chown -R apache. /var/www/
RUN chmod -R 777 /var/www/html/
RUN chmod -R 777 /var/www/moodledata


USER 997
EXPOSE 8080
CMD ["/bin/sh", "/run_wordpress.sh"]

