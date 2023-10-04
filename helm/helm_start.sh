#!/bin/bash

# Running first time
#helm repo add hashicorp https://helm.releases.hashicorp.com
#helm repo add runix https://helm.runix.net
#helm repo add codecentric https://codecentric.github.io/helm-charts

# Init
minikube start --memory 20000 --cpus=6 --driver=kvm2 --addons ingress
sudo ../scripts/hosts_remover.sh /etc/hosts
sudo ../scripts/hosts_populator.sh /etc/hosts $(minikube ip)
kubectl apply -f ../k8s/infra/_namespace-loans.yaml
kubectl apply -f grafana-dashboard.yaml

sleep 20

# Install Helm services
helm upgrade --install elasticsearch oci://registry-1.docker.io/bitnamicharts/elasticsearch -n loans
helm upgrade --install fluent-bit oci://registry-1.docker.io/bitnamicharts/fluent-bit --values fluent-bit-values.yml -n loans
helm upgrade --install grafana oci://registry-1.docker.io/bitnamicharts/grafana --values grafana-values.yml -n loans
helm upgrade --install kibana oci://registry-1.docker.io/bitnamicharts/kibana --values kibana-values.yml -n loans
helm upgrade --install mailhog codecentric/mailhog --values mailhog-values.yml -n loans
helm upgrade --install pgadmin runix/pgadmin4 --values pgadmin-values.yml -n loans
helm upgrade --install postgres oci://registry-1.docker.io/bitnamicharts/postgresql --values postgres-values.yml -n loans
helm upgrade --install prometheus oci://registry-1.docker.io/bitnamicharts/prometheus --values prometheus-values.yml -n loans
helm upgrade --install rabbitmq oci://registry-1.docker.io/bitnamicharts/rabbitmq --values rabbitmq-values.yml -n loans
helm upgrade --install redis oci://registry-1.docker.io/bitnamicharts/redis --values redis-values.yml -n loans
helm upgrade --install redis-commander ./redis-commander --values redis-commander-values.yml -n loans
helm upgrade --install vault hashicorp/vault --values vault-values.yml -n loans

# Seed
../scripts/seed_vault.sh vault.osber.io
../scripts/seed_kibana.sh kibana.osber.io create_data_view-k8s-1.json
../scripts/seed_kibana.sh kibana.osber.io create_data_view-k8s-2.json

helm upgrade --install back-office ./spring-boot --values back-office-values.yml -n loans
helm upgrade --install risk-checker ./spring-boot --values risk-checker-values.yml -n loans
helm upgrade --install notifications-service ./spring-boot --values notification-service-values.yml -n loans

