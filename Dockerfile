FROM jenkins:2.60.3-alpine

USER root

#USER jenkins


RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
#update libc6 and install filebeat
RUN apk update && apk add libc6-compat && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
RUN curl -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-linux-x86_64.tar.gz && \
    tar -xvzf filebeat-6.2.4-linux-x86_64.tar.gz && \
    mv /filebeat-6.2.4-linux-x86_64/filebeat /usr/bin/ 
COPY filebeat.yml /filebeat-6.2.4-linux-x86_64/filebeat.yml
COPY run.sh /startpoint/
RUN chmod go-w /filebeat-6.2.4-linux-x86_64/filebeat.yml && \
    chmod 777 /startpoint/run.sh
ENV PATH $PATH:/startpoint/
COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/
ADD ref /usr/share/jenkins/ref/
COPY jobs/ /usr/share/jenkins/ref/jobs/
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
COPY plugins/hubot-steps.hpi /var/jenkins_home/plugins/hubot-steps.hpi
ENV ADOP_LDAP_ENABLED=true LDAP_IS_MODIFIABLE=true ADOP_ACL_ENABLED=true
ENV LDAP_GROUP_NAME_ADMIN=""
ENV JENKINS_OPTS="--prefix=/jenkinscore -Djenkins.install.runSetupWizard=false"

VOLUME /var/jenkins_home
RUN mkdir /var/log/jenkins
ENTRYPOINT ["run.sh"]
