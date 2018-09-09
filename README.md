

# Description
ECS/Dockerized Jenkins with a backend of EFS for persistent configurations

# Usage
git clone ecs-jenkins-efs-backend
cd ecs-jenkins-efs-backend
docker build -t thecrockett/ecs-jenkins-efs-backend . 
docker run --privileged=true -p 8080:8080 -e JENKINS_EFS_HOST=${YOU_EFS_HOST_DNS} thecrockett/ecs-jenkins-efs-backend

# Thanks internavenue
Based extremenly heavily on internavenue/centos-jenkins

