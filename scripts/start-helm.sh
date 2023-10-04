#!/bin/bash

# Running first time
#helm repo add hashicorp https://helm.releases.hashicorp.com
#helm repo add runix https://helm.runix.net
#helm repo add codecentric https://codecentric.github.io/helm-charts

# Init
minikube start --memory 20000 --cpus=6 --driver=kvm2 --addons ingress
sudo ./hosts_remover.sh /etc/hosts
sudo ./hosts_populator.sh /etc/hosts $(minikube ip)
kubectl apply -f ../k8s/infra/_namespace-loans.yaml
kubectl apply -f ../helm/grafana-dashboard.yaml

sleep 20

# Install Helm services
helm upgrade --install elasticsearch oci://registry-1.docker.io/bitnamicharts/elasticsearch -n loans
helm upgrade --install fluent-bit oci://registry-1.docker.io/bitnamicharts/fluent-bit --values ../helm/fluent-bit-values.yml -n loans
helm upgrade --install grafana oci://registry-1.docker.io/bitnamicharts/grafana --values ../helm/grafana-values.yml -n loans
helm upgrade --install kibana oci://registry-1.docker.io/bitnamicharts/kibana --values ../helm/kibana-values.yml -n loans
helm upgrade --install mailhog codecentric/mailhog --values ../helm/mailhog-values.yml -n loans
helm upgrade --install pgadmin runix/pgadmin4 --values ../helm/pgadmin-values.yml -n loans
helm upgrade --install postgres oci://registry-1.docker.io/bitnamicharts/postgresql --values ../helm/postgres-values.yml -n loans
helm upgrade --install prometheus oci://registry-1.docker.io/bitnamicharts/prometheus --values ../helm/prometheus-values.yml -n loans
helm upgrade --install rabbitmq oci://registry-1.docker.io/bitnamicharts/rabbitmq --values ../helm/rabbitmq-values.yml -n loans
helm upgrade --install redis oci://registry-1.docker.io/bitnamicharts/redis --values ../helm/redis-values.yml -n loans
helm upgrade --install redis-commander ../helm/redis-commander --values ../helm/redis-commander-values.yml -n loans
helm upgrade --install vault hashicorp/vault --values ../helm/vault-values.yml -n loans

# Seed
./seed_vault.sh vault.osber.io
./seed_kibana.sh kibana.osber.io create_data_view-k8s-1.json
./seed_kibana.sh kibana.osber.io create_data_view-k8s-2.json

helm upgrade --install back-office ../helm/spring-boot --values ../helm/back-office-values.yml -n loans
helm upgrade --install risk-checker ../helm/spring-boot --values ../helm/risk-checker-values.yml -n loans
helm upgrade --install notifications-service ../helm/spring-boot --values ../helm/notification-service-values.yml -n loans

