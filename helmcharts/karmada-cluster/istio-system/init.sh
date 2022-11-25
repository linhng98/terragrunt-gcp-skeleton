!#/bin/bash
kubectl create ns istio-system
kubectl label namespace istio-system topology.istio.io/network=karmada-cluster-network
