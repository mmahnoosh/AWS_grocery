# Deployment Guide for AWS Grocery App (Terraform Deployment)

## 🏆 GroceryMate E-Commerce Platform

[![Python](https://img.shields.io/badge/Language-Python%2C%20JavaScript-blue)](https://www.python.org/)
[![OS](https://img.shields.io/badge/OS-Linux%2C%20Windows%2C%20macOS-green)](https://www.kernel.org/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL-336791)](https://www.postgresql.org/)
[![GitHub Release](https://img.shields.io/github/v/release/AlejandroRomanIbanez/AWS_grocery)](https://github.com/AlejandroRomanIbanez/AWS_grocery/releases/tag/v2.0.0)
[![Free](https://img.shields.io/badge/Free_for_Non_Commercial_Use-brightgreen)](#-license)

⭐ **Star us on GitHub** — it motivates us a lot!

---
## 📌 Table of Contents

- [📖 Introduction](#-introduction)
- [🛒 Features](#-features)
- [☁️ AWS Services](#aws-services)
- [🏗️ Architecture & Approach](#-architecture--approach)
- [📷 Architecture Diagram](#-architecture-diagram)
- [⚙️ Components](#-components)
- [🛠️ Terraform Layout](#-terraform-layout)
- [📸 Screenshots & Demo](#-screenshots--demo)
- [📋 Prerequisites](#-prerequisites)
- [🚀 Deployment Steps](#-deployment-steps)
- [🐘 PostgreSQL Setup](#-postgresql-setup)
- [🛢️ AWS RDS Setup](#-aws-rds-setup)
- [⚙️ Configuration Variables](#-configuration-variables)
- [🧹 Cleanup](#-cleanup)
- [🔧 Environment Variables](#-environment-variables)
- [▶️ Run the Application](#-run-the-application)
- [💰 Cost Considerations](#-cost-considerations)
- [✅ Summary](#-summary)
- [🧑‍💻 Contributing](#-contributing)
- [📜 License](#-license)

  
## 📖 Introduction

GroceryMate is an application developed as part of the Masterschools program by Alejandro Roman Ibanez.
It is a modern, full-featured e-commerce platform designed for seamless online grocery shopping, providing an intuitive user interface and a secure backend. Users can browse products, manage their shopping basket, and complete purchases efficiently.

This project demonstrates how to deploy a production-like webshop on AWS using core services such as EC2, RDS, ALB, S3, CloudWatch, Route 53, IAM. 
It highlights key cloud fundamentals:
- Networking & Security with VPC, public/private subnets, and security groups
- High Availability with Multi-AZ RDS and Application Load Balancer
- Scalability with EC2 Auto Scaling
- Monitoring & Alerts with CloudWatch, EventBridge, and SNS
- Infrastructure as Code with Terraform

> This document focuses exclusively on the AWS infrastructure, deployment process, and automation.
> For details about the application's features, functionality, and local installation, refer to the original [`README.md`](APPLICATION.md) by Alejandro.


## 🛒 Features

- **🛡️ Authentication**: Secure login & session management
- **🔒 Protected Routes**: Access control for authenticated users
- **🔎 Product Search & Filtering**: Browse products, apply filters, and sort by category or price.
- **⭐ Favorites Management**: Save preferred products.
- **🛍️ Shopping Basket**: Add, view, modify, and remove items.
- **💳 Checkout Process**: with billing, shipping & payments

## ☁️ AWS Services

| Service | Purpose |
|---------|---------|
| **Route 53** | DNS & domain management |
| **EC2** | Web app hosting |
| **ALB** | Load balancing |
| **RDS (PostgreSQL)** | Primary & standby DB |
| **S3** | Static assets, avatars |
| **Lambda** | Automation tasks |
| **EventBridge** | Event-driven workflows |
| **IAM** | Roles & permissions |
| **CloudWatch** | Monitoring, logs |
| **SNS** | Alerts & notifications |


  
## 🏗️ Architecture & Approach

### Highly available AWS architecture across two AZs:

- **Route 53** → ALB (Public Subnets) – entry point for HTTPS traffic
- **EC2** (Auto Scaling, Public Subnets) – app servers, reachable through ALB
- **RDS PostgreSQL** (Multi-AZ, Private Subnets) – not publicly accessible, only from VPC
- **S3** – avatar and static asset storage (versioning enabled)
- **CloudWatch, EventBridge, SNS – monitoring, logging & alerts**
- **IAM Roles & Security Groups** – controlled access

### Network Layout

- **Public Subnets** (per AZ): ALB, EC2, NAT GW
- **Private Subnets** (per AZ): RDS, potential future services
- **Routing**:
    - Public Subnets → 0.0.0.0/0 → IGW
    - Private Subnets → 0.0.0.0/0 → NAT GW in same AZ
      
## 📷 Architecture Diagram

<img width="811" height="1036" alt="MyDiagram3009" src="https://github.com/user-attachments/assets/25e55fdb-a578-4f2a-90f1-717efad024b9" />

## ⚙️ Components

- Amazon Route 53 – DNS & domain
- Application Load Balancer (ALB) – HTTPS entry point
- Amazon EC2 (Auto Scaling, Public Subnets) – app servers
- Amazon RDS PostgreSQL (Private Subnets, Multi-AZ) – database
- Amazon S3 – avatars & static assets
- Amazon CloudWatch, EventBridge, SNS – monitoring, events, alerts
- IAM Roles & Security Groups – permissions & access control
- VPC with Public + Private Subnets


## 🛠️ Terraform Layout

```text
/infrastructure
├─ main.tf
├─ variables.tf
├─ outputs.tf
├─ terraform.tfvars
├─ networking/
│  ├─ vpc.tf
│  ├─ subnets.tf         
│  ├─ igw.tf
│  ├─ routes.tf           
├─ security/
│  └─ security_groups.tf
├─ compute/
│  ├─ alb.tf
│  ├─ asg_launch_template.tf
│  └─ asg.tf
├─ database/
│  └─ rds.tf
└─ s3/
   └─ bucket.tf

```

## 📸 Screenshots & Demo

![imagen](https://github.com/user-attachments/assets/ea039195-67a2-4bf2-9613-2ee1e666231a)


https://github.com/user-attachments/assets/d1c5c8e4-5b16-486a-b709-4cf6e6cce6bc

## 📋 Prerequisites

- AWS account
- AWS CLI installed & configured (aws configure)
- Terraform v1.5+
- PostgreSQL client (psql)
- AWS SSH key pair (optional if debugging)

## 🚀 Deployment Steps

### 🔹 Clone the Repository

```sh
git clone https://github.com/<your-username>/AWS_grocery.git && cd AWS_grocery
```

### 🔹 Initialize Terraform
```sh
terraform init
```

### 🔹 Preview changes
```sh
terraform plan

```
### 🔹 Deploy
```sh
terraform apply -auto-approve
```

### 🔹 Access the application
```sh
terraform output
```
This will print the ***API Gateway endpoint***.

## 🐘 PostgreSQL Setup

You need a PostgreSQL database and a user before running the application.  
This can be done locally or with AWS RDS.

### Local

1. Log in to PostgreSQL:
   ```bash
   psql -U postgres
2. Create the database and user:
```bash
   CREATE DATABASE grocerymate_db;
   CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<your_secure_password>';
   GRANT ALL PRIVILEGES ON DATABASE grocerymate_db TO grocery_user;
```
3. Verify that the tables can be accessed:
```bash
\c grocerymate_db
\dt
```
## 🛢️AWS RDS Setup

1. Create PostgreSQL RDS instance in same VPC
2. Open port 5432 for Lambda’s security group
3. Connect
```bash
psql -h <RDS_ENDPOINT> -U grocery_user -d grocerymate_db
```
4. Update your .env file with the RDS endpoint:
```bash
POSTGRES_HOST=<your_rds_endpoint>
```

# 🛠️ Variables

|        Variable        |      Description      |   Default     |
|------------------------|-----------------------|---------------|
| `db_username`          | RDS username          | `postgres`    |
| `db_password`          | RDS password          | set manually  |
| `vpc_cidr`             | VPC CIDR block        | `10.10.0.0/16`|
| `public_subnet_cidr`   | Public subnet CIDR    | `10.10.1.0/24`|

## 🧹 Cleanup

To avoid unnecessary AWS costs, destroy resources when not needed:
```bash
terraform destroy -auto-approve
```

## 🔧 Environment Variables
```sh
nano .env
```

Fill in the following information (make sure to replace the placeholders):

```ini
JWT_SECRET_KEY=<your_generated_key>
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=<your_rds_endpoint>
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}

```

## 🔹 Run the Application

```bash
python3 run.py
```

## 📊 Cost Considerations

- **EC2** t3.micro (Public): free tier eligible / low-cost
- **RDS**: db.t3.micro (~ free tier 12 months)
- **S3**: Low cost, pay per storage and requests
- **CloudWatch**: pay per log volume


## ✅ Summary

This setup deploys a secure, highly available architecture:
Route 53 → ALB (Public) → EC2 (Public) → RDS (Private, Multi-AZ)
Provisioned via Terraform, monitored via CloudWatch & SNS.

## 🧑‍💻 Contributing

Contributions, issues, and feature requests are welcome!  
Here’s how you can contribute:

1. **Fork** the repository  
2. Create a new branch:  
   ```bash
   git checkout -b feature/your-feature


## 📜 License

This project is licensed under the MIT License.
