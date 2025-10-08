Terraform 3-tier AWS project 👇

# 🌐 3-Tier AWS Architecture using Terraform

This project provisions a **3-tier architecture** (Web, Application, and Database layers) on **AWS** using **Terraform**.  
It demonstrates Infrastructure as Code (IaC) to automate and manage AWS resources efficiently.

---

## 🏗️ Project Overview

The 3-tier architecture consists of:

- **VPC** – Custom Virtual Private Cloud with public and private subnets  
- **EC2 Instances** – Web servers hosted in public subnets  
- **RDS** – MySQL database in private subnets  
- **Security Groups** – To control inbound and outbound traffic  
- **Internet Gateway & Route Tables** – For public internet access  

---

## ⚙️ Prerequisites

Before running the project, ensure you have:

- **Terraform** installed (`>= 1.5.0`)  
- **AWS CLI** configured with valid credentials  
- An **existing AWS Key Pair** (update the name in `main.tf`)

---

## 🚀 How to Use

```bash
# Initialize Terraform
terraform init

# Validate the configuration
terraform validate

# Preview the resources
terraform plan

# Apply the configuration
terraform apply -auto-approve

# Destroy the infrastructure
terraform destroy -auto-approve

📂 Project Structure
3tier-terraform/
├── main.tf          # Main Terraform configuration
├── provider.tf      # AWS provider settings
├── variables.tf     # Variable definitions
├── outputs.tf       # Output values (e.g., IPs, DB endpoint)
└── README.md        # Project documentation

✅ Done!
