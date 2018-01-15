import jenkins.model.*

def inst = Jenkins.getInstance()

def desc = inst.getDescriptor("jenkins.plugins.logstash.LogstashInstallation")

desc.setType("ELASTICSEARCH")
desc.setHost("http://elasticsearch.ethan.svc.cluster.local")
desc.setPort("9200")
desc.setKey("logstash-jenkins/jenkins")
desc.setSyslogProtocol("UDP")

desc.save()
