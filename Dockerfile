FROM centos:7
MAINTAINER Josue Ramirez

# Install EPEL Repo
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && yum -y install epel-release yum-utils
RUN yum-config-manager --disable remi-php54 && yum-config-manager --enable remi-php73

RUN yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-imagick php-intl php-xmlrpc php-soap php-opcache
# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf


ADD moodle.tar.gz /moodle/
RUN mkdir /opt/app-root/moodledata
COPY httpd.conf / 
COPY run_wordpress.sh /
COPY config.php /
#COPY ssmtp /etc/ssmtp
COPY php.ini /etc/opt/remi/php70/php.ini
#UN rm -fr /run/httpd; ln -sf /tmp/run/httpd /run/httpd


VOLUME /opt/app-root/


RUN chmod a+rw /etc/passwd
#RUN chmod a+rw /etc/ssmtp
RUN chown -R apache. /opt/app-root/
RUN chmod -R 777 /opt/app-root/



USER 997
EXPOSE 8080
CMD ["/bin/sh", "/run_wordpress.sh"]

