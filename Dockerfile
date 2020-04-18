FROM centos:7
#FROM eliseo247/redhat7php7
#FROM ubi7/php-73
#FROM registry.access.redhat.com/ubi7/php-73
MAINTAINER Josue Ramirez

# Install EPEL Repo
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && yum -y install epel-release yum-utils
RUN yum-config-manager --disable remi-php54 && yum-config-manager --enable remi-php73

RUN yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-imagick
# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf



ADD moodle.tar.gz /moodle/
RUN mkdir /var/www/moodledata
COPY httpd.conf / 
COPY run_wordpress.sh /
#COPY ssmtp /etc/ssmtp
COPY php.ini /etc/opt/remi/php70/php.ini
RUN rm -fr /run/httpd; ln -sf /tmp/run/httpd /run/httpd


VOLUME /var/www/html


RUN chmod a+rw /etc/passwd
#RUN chmod a+rw /etc/ssmtp
RUN chown -R apache. /var/www/
RUN chmod -R 755 /var/www/html/
RUN chmod -r 755 /var/www/moodledata/


USER 997
EXPOSE 8080
CMD ["/bin/sh", "/run_wordpress.sh"]

LABEL io.k8s.description="Wordpress" \
      io.k8s.display-name="wordpress apache centos7 epel php7" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,wordpress,apache" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
