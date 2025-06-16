#!/bin/bash

echo "Launching Kubernetes master and worker nodes with Multipass..."

multipass launch jammy --name k8s-master --cpus 2 --memory 4G --disk 20G
multipass launch jammy --name k8s-worker1 --cpus 2 --memory 2G --disk 20G
multipass launch jammy --name k8s-worker2 --cpus 2 --memory 2G --disk 20G

echo "✅ All nodes launched successfully!"
