#!/bin/bash

mkdir -p ~/kube/07/svc && cd ~/kube/07/svc 
> ip.txt

loop() {
kubectl create -f test-svc.yml >/dev/null 2>&1
sleep 1
kubectl get svc clusterip-svc | tail -1 | awk '{print $3}' | tee -a ip.txt
kubectl delete -f test-svc.yml >/dev/null 2>&1
sleep 0.5
}

for i in {1..10}
do
	echo "[$i]: $(loop)"
done
cat ip.txt
