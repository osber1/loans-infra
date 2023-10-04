#!/bin/bash

helm uninstall argocd -n loans
helm uninstall elasticsearch -n loans
helm uninstall fluent-bit -n loans
helm uninstall grafana -n loans
helm uninstall kibana -n loans
helm uninstall mailhog -n loans
helm uninstall pgadmin -n loans
helm uninstall postgres -n loans
helm uninstall prometheus -n loans
helm uninstall rabbitmq -n loans
helm uninstall redis -n loans
helm uninstall redis-commander -n loans
helm uninstall vault -n loans
helm uninstall back-office -n loans
helm uninstall risk-checker -n loans
helm uninstall notifications-service -n loans
