import org.csanchez.jenkins.plugins.kubernetes.*
import jenkins.model.*

// Variables
def env = System.getenv()
def kube_master = env['KUBERNETES_SERVICE_HOST']
def kube_port = env['KUBERNETES_SERVICE_PORT']

def instance = Jenkins.getInstance()

//Plugin configuration
def name = "kubernetes"
def kube_url = "https://"+kube_master+":"+kube_port
def kube_ns = "ethan"
def jenkins_url = "http://jenkins-blueocean.ethan.svc.cluster.local:8080/jenkins"
def containerCapStr = "10"
def connectTimeout = 0
def readTimeout = 0
def retentionTimeout = 5
def maxRequestsPerHost = "32"

def kc =  new KubernetesCloud( name, null, kube_url, kube_ns, jenkins_url, containerCapStr, connectTimeout, readTimeout, retentionTimeout)

kc.setSkipTlsVerify(true)
kc.setMaxRequestsPerHostStr(maxRequestsPerHost)
instance.clouds.replace(kc)
instance.save()
