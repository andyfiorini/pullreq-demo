FROM centos:latest
RUN yum -y install wget
RUN wget -O /etc/yum.repos.d/cloudfoundry-cli.repo https://packages.cloudfoundry.org/fedora/cloudfoundry-cli.repo
RUN yum -y install git cf-cli 
RUN cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org && yes | cf install-plugin blue-green-deploy -r CF-Community
