#!/bin/bash
filebeat -c /filebeat-6.2.4-linux-x86_64/filebeat.yml -e -v -d "*" &
/usr/local/bin/jenkins.sh
