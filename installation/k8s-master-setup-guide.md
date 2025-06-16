# Kubernetes Master Node Setup Guide (Clean & Stable Installation)

This guide documents the clean and stable setup process of a single-node Kubernetes cluster (control-plane only), tested on Ubuntu 20.04+.

---

## ✅ 1. System Preparation

### Disable swap
```bash
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
```

### Load kernel modules and sysctl settings
```bash
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system
```

---

## ✅ 2. Install Container Runtime (Containerd)

```bash
sudo apt update
sudo apt install -y containerd
```

Create default config:
```bash
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
```

Restart the service:
```bash
sudo systemctl restart containerd
sudo systemctl enable containerd
```

---

## ✅ 3. Install Kubernetes Components

```bash
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" |   sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

---

## ✅ 4. Initialize Kubernetes Cluster (Master Node)

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

Then:
```bash
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---

## ✅ 5. Install Pod Network (Flannel)

```bash
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

---

## ✅ 6. Check Cluster Status

```bash
kubectl get nodes
kubectl get pods -A
```

All pods should be in `Running` status.

---

## 🔁 Optional: Reset the Cluster if Broken

```bash
sudo kubeadm reset -f
sudo systemctl stop kubelet
sudo systemctl stop containerd
sudo rm -rf /etc/cni /var/lib/cni /var/lib/kubelet /etc/kubernetes /var/lib/etcd ~/.kube
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X
```

---

## 🎉 You're Ready!

The master node is now ready. You can proceed to:

- Join worker nodes
- Deploy test pods
- Secure and optimize your cluster

---

*Created by: ChatGPT & Gizem 👩‍💻*