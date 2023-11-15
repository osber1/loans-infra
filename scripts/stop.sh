#!/bin/bash    

VERSION="1.0-SNAPSHOT"

sudo ./hosts_remover.sh /etc/hosts

minikube delete

docker compose -f ../docker/docker-compose.yml -f ../docker/docker-compose-applications.yml down

docker rmi osvasldas97/back-office:$VERSION
docker rmi osvasldas97/risk-checker:$VERSION
docker rmi osvasldas97/notification-service:$VERSION