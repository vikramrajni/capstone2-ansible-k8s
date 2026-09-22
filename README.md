This project demonstrates how to provision an Amazon EKS (Elastic Kubernetes Service) cluster using Terraform and deploy a containerized application to Kubernetes using Ansible.

The infrastructure and deployment workflow is separated into two phases:
- Infrastructure Provisioning using Terraform
- Application Deployment using Ansible

This approach provides Infrastructure as Code (IaC) for the Kubernetes platform while using Ansible to automate Kubernetes application deployments.

**Prerequisites**

Before starting, ensure the following tools are installed:

  **AWS CLI**
  aws --version

 **Terraform**
  terraform version

  **kubectl**
  kubectl version --client

  **Ansible**
  ansible --version

  **Python Dependencies**
  sudo apt update
  sudo apt install python3-kubernetes -y
  sudo apt install python3-jsonpatch -y

**Step 1: Create the Amazon EKS Cluster**
Provision the EKS infrastructure using Terraform.
Initialize Terraform
  terraform init
  terraform validate
  terraform plan
  terraform apply

**Step 2: Generate the Kubernetes Configuration File**
Once the EKS cluster has been created, generate a kubeconfig file that Ansible will use to connect to the Kubernetes API.

aws eks update-kubeconfig \
    --region us-east-1 \
    --name myapp-eks-cluster \
    --kubeconfig kubeconfig.yaml

Verify Cluster Connectivity
kubectl --kubeconfig kubeconfig.yaml get nodes

*******************
Traditional Ansible automation requires an inventory file (hosts) containing target servers.
For Kubernetes deployments, the inventory file is unnecessary because:
Ansible communicates directly with the Kubernetes API server.
Cluster access is provided through the kubeconfig file.
*******************
**Step 3: Define the Kubernetes Application**

The Kubernetes deployment configuration is stored in: nginx-config.yaml

**Step 4: Create the Ansible Playbook**
deploy-to-k8s.yaml

**Step 5: Deploy the Application**
ansible-playbook deploy-to-k8s.yaml
