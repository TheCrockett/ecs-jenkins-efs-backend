#!/bin/bash 
# Starts up Jenkins within the container.

# Stop on error
set -e

LIB_DIR=/var/lib/jenkins
LOG_DIR=/var/log
CACHE_DIR=/var/cache/jenkins/war

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action


#chown -R jenkins:jenkins $LIB_DIR
find ${LIB_DIR} -not -user jenkins -execdir chown jenkins {} \+
#chown -R jenkins:jenkins $CACHE_DIR
find ${CACHE_DIR} -not -user jenkins -execdir chown jenkins {} \+
#chown -R jenkins:jenkins "$LOG_DIR/jenkins"
find $LOG_DIR/jenkins -not -user jenkins -execdir chown jenkins {} \+

echo "Mounting EFS..."
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${JENKINS_EFS_HOST}:/ /var/lib/jenkins
chown -R jenkins:jenkins /var/lib/jenkins

echo "Starting Jenkins..."
/etc/init.d/jenkins start
