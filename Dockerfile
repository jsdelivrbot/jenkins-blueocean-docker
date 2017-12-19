FROM jenkins:2.60.3-alpine

USER jenkins

RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

COPY plugins.txt /usr/share/jenkins/ref/
COPY adop_ldap.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY role_based_auth.groovy /usr/share/jenkins/ref/init.groovy.d/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

ENV ADOP_LDAP_ENABLED=true LDAP_IS_MODIFIABLE=true ADOP_ACL_ENABLED=true
ENV LDAP_GROUP_NAME_ADMIN=""
ENV JENKINS_OPTS="--prefix=/jenkins -Djenkins.install.runSetupWizard=false"

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
