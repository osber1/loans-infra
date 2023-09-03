#!/bin/bash

# Running for the first time
#helm repo add argo-cd https://argoproj.github.io/argo-helm

#minikube start --memory 20000 --cpus=6 --driver=kvm2 --addons ingress

sudo ./hosts_remover.sh /etc/hosts
sudo ./hosts_populator.sh /etc/hosts $(minikube ip)

sleep 30

kubectl apply -f ../k8s/infra/_namespace-loans.yaml
helm upgrade --install argocd ../helm/argo-cd --values ../helm/argocd-values.yml -n loans

sleep 10

kubectl apply -f ../applications

./seed_vault.sh vault.osber.io
./seed_kibana.sh kibana.osber.io create_data_view-k8s-1.json
./seed_kibana.sh kibana.osber.io create_data_view-k8s-2.json

#sleep 50

echo "ArgoCD password: $(kubectl -n loans get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"

