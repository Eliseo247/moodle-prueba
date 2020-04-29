 
FROM ansp/php-73-rhel7:latest  
MAINTAINER Joeri van Dooren

VOLUME /opt/app-root/src

USER 997
EXPOSE 8080
CMD ["/bin/bash", "/run_wordpress.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Wordpress" \
      io.k8s.display-name="wordpress apache centos7 epel" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,wordpress,apache" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
