🛡️ Dream Games - SecOps Case Study

This project demonstrates a hands-on approach to securing a Kubernetes-based game backend system. It includes infrastructure provisioning, image scanning, secrets management, RBAC policies, and observability tools.

🔧 Tools Used

Multipass (VM management)

Kubernetes (with kubeadm)

Trivy (Image vulnerability scanning)

Prometheus + Grafana (Monitoring)

Fluent Bit + ELK Stack (Logging)

Sealed Secrets, TLS, RBAC

📁 Project Structure

dreamgames-secops-case/
├── README.md
├── multipass-setup/
│   ├── create_nodes.sh
│   ├── install_kubeadm.sh
├── kubernetes/
│   ├── backend-app/
│   │   ├── Dockerfile
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── ingress.yaml
│   └── monitoring/
│       └── prometheus-grafana.yaml
├── security-tools/
│   ├── trivy-scan-result.txt
│   ├── sealed-secret-example.yaml
│   └── gitleaks-output.json
├── screenshots/
│   ├── grafana-dashboard.png
│   └── trivy-output.png

🚀 Getting Started

Clone the repository:

git clone https://github.com/gzmkcc/dreamgames-secops-case.git

Launch the VMs via Multipass:

bash multipass-setup/create_nodes.sh

SSH into the master node:

multipass shell k8s-master

Run the Kubernetes installation script:

bash multipass-setup/install_kubeadm.sh

🌟 Goal

Demonstrate end-to-end Kubernetes security practices for a hypothetical Dream Games backend infrastructure.

📄 Output

Working Kubernetes cluster

Secure deployment pipeline

Audit and monitoring setup

GitHub repo with full documentation and YAMLs

