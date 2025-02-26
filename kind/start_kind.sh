#!/bin/bash

set -x

SCRIPTDIR=$(cd $(dirname "$0") && pwd)

KIND_NODE_TAG=v1.25.2

# Boot cluster
kind create cluster --config "$SCRIPTDIR/kind-cluster.yml" --image kindest/node:${KIND_NODE_TAG} --wait 10m || exit 1

echo "Kubernetes cluster is deployed and reachable"
kubectl cluster-info --context kind-funless-cluster
kubectl apply -f namespace.yml
kubectl apply -f svc-account.yml
kubectl apply -f prometheus-cm.yml
kubectl apply -f prometheus.yml
kubectl apply -f core-secret-postgres-user.yml
kubectl apply -f core-secret-postgres-password.yml
kubectl apply -f postgres.yml
kubectl apply -f core-secret-key-base.yml
kubectl apply -f core.yml
kubectl apply -f worker.yml
kubectl apply -f core-secret-kibana-password.yml
kubectl apply -f elasticsearch.ym
kubectl apply -f filebeat-config.yml
kubectl apply -f filebeat.yml
kubectl apply -f kibana.yml
