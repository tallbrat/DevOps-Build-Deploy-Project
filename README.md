## Project Description

This project aims to automate the provisioning and configuration of infrastructure components using Terraform for infrastructure provisioning and Ansible for configuration management.

The Infrastructure Provisioning directory contains subdirectories for different infrastructure components such as compute resources and network resources. Within each subdirectory, Terraform configuration files define the infrastructure resources to be provisioned.

The Ansible roles directory contains roles for configuring various components using Ansible. Each role encapsulates configuration tasks related to a specific component such as Docker, Jenkins, or Kubernetes.

Additionally, Ansible playbooks are provided for tasks such as copying Kubernetes files to remote servers and generating SSH keys on master and worker nodes.

Jenkins pipelines (*jenkinsfile-CI* and *jenkinsfile-CD*) automate the continuous integration and deployment processes, respectively.

## Folder Structure
─ src  
─ Infrastructure Provisioning  
  ├── Ansible roles  
  │   ├── Ansible  
  │   ├── Docker  
  │   ├── git  
  │   ├── jenkins  
  │   ├── kubectl  
  │   ├── minikube    
  │   └── trivy  
  ├── compute  
  │   ├── ec2-instance  
  │   │   ├── private_ec2_instance  
  │   │   └── public_ec2_instance  
  │   └── security_groups  
  ├── Network    
  │   ├── internet_gateway  
  │   ├── nat_gateway  
  │   ├── private_key  
  │   ├── route_table  
  │   ├── subnet  
  │   └── vpc  
  ├── all_tool_jenkins-server.yml  
  ├── all_tools_k8s-server.yml  
  ├── main.tf  
  ├── output.tf  
  ├── provider.tf  
  ├── terraform.tfvar  
  ├── variable.tf  
  └── dockerfile  
─ copy-k8s-file-to-remote.yml  
─ jenkinsfile-CI  
─ jenkinsfile-CD  
─ ssh-master-node.yml  
─ ssh-worker-node.yml
