!#/bin/bash
kubectl create ns istio-system
kubectl annotate namespace istio-system topology.istio.io/controlPlaneClusters=karmada-cluster
kubectl label --overwrite="true" namespace istio-system topology.istio.io/network=serverless-cluster-b-network