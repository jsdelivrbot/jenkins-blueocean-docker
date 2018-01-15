FROM jenkins:2.60.3-alpine

USER root

#USER jenkins


RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion


COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/
ADD ref /usr/share/jenkins/ref/
COPY jobs/ /usr/share/jenkins/ref/jobs/
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
ENV ADOP_LDAP_ENABLED=true LDAP_IS_MODIFIABLE=true ADOP_ACL_ENABLED=true
ENV LDAP_GROUP_NAME_ADMIN=""
ENV JENKINS_OPTS="--prefix=/jenkins -Djenkins.install.runSetupWizard=false"

VOLUME /var/jenkins_home
RUN mkdir /var/log/jenkins
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
