FROM rockylinux/rockylinux:8

MAINTAINER Brian Crockett - bcrockett@richmondsystemengineering.com>

RUN yum -y install wget 

RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

RUN yum install -y epel-release

RUN yum -y --nogpgcheck install \
  nfs-utils \
  java-11-openjdk \
  initscripts \
  jenkins



# Clean up YUM when done.
RUN yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /first_run

# The --deaemon removed from the init file.
ADD etc/jenkins /etc/init.d/jenkins
RUN chmod +x /etc/init.d/jenkins

EXPOSE 8080 

# Kicking in
CMD ["/scripts/start.sh"]

