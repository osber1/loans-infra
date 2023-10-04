#!/bin/bash

minikube start --memory 20000 --cpus=6 --driver=kvm2 --addons ingress

sudo ./hosts_remover.sh /etc/hosts
sudo ./hosts_populator.sh /etc/hosts $(minikube ip)

sleep 30

kubectl apply -f ../k8s/infra/_namespace-loans.yaml
helm upgrade --install argocd oci://registry-1.docker.io/bitnamicharts/argo-cd --values ../helm/argocd-values.yml -n loans

sleep 10

kubectl apply -f ../argo-cd-applications/infra

./seed_vault.sh vault.osber.io
./seed_kibana.sh kibana.osber.io create_data_view-k8s-1.json
./seed_kibana.sh kibana.osber.io create_data_view-k8s-2.json

kubectl apply -f ../argo-cd-applications/services

echo "ArgoCD password: $(kubectl -n loans get secret argocd-secret -o jsonpath="{.data.clearPassword}" | base64 -d)"

