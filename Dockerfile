FROM centos:7
#FROM eliseo247/redhat7php7
#FROM ubi7/php-73
#FROM registry.access.redhat.com/ubi7/php-73
MAINTAINER Josue Ramirez

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && yum -y install epel-release yum-utils
RUN yum-config-manager --disable remi-php54 && yum-config-manager --enable remi-php73

# RUN yum -y install epel-release && yum -y install httpd wget unzip git pwgen supervisor bash-completion psmisc tar mysql
#RUN yum -y install php70 php70-php php70-php-mbstring php70-php-gd php70-php-dom php70-php-pdo php70-php-mysqlnd php70-php-mcrypt php70-php-process php70-php-pear php70-php-cli php70-php-xml php70-php-curl php70-php-phalcon2 && yum --enablerepo=epel -y install ssmtp && yum clean all -y

###RUN yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-imagick
# Update Apache Configuration
RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf



ADD wordpress.tar.gz /usr/share/httpd/
#COPY httpd.conf / 
#COPY run_wordpress.sh /
#COPY ssmtp /etc/ssmtp
#COPY php.ini /etc/opt/remi/php73/php.ini
#COPY wp-config.php /

#RUN rm -fr /run/httpd; ln -sf /tmp/run/httpd /run/httpd

VOLUME /var/www/html


#RUN chmod a+rw /etc/passwd
#RUN chmod a+rw /etc/ssmtp
#RUN chown -R apache. /var/www/
#RUN chmod -R 755 /var/www/html/


#USER 997
#EXPOSE 8080
##CMD ["/bin/sh", "/run_wordpress.sh"]

# Label para describir la construccion de la imagen
#LABEL io.k8s.description="Wordpress" \
