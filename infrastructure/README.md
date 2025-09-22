## Deployment Guide for AWS Grocery App (Terraform Deployment)

## 🏆 GroceryMate E-Commerce Platform

[![Python](https://img.shields.io/badge/Language-Python%2C%20JavaScript-blue)](https://www.python.org/)
[![OS](https://img.shields.io/badge/OS-Linux%2C%20Windows%2C%20macOS-green)](https://www.kernel.org/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL-336791)](https://www.postgresql.org/)
[![GitHub Release](https://img.shields.io/github/v/release/AlejandroRomanIbanez/AWS_grocery)](https://github.com/AlejandroRomanIbanez/AWS_grocery/releases/tag/v2.0.0)
[![Free](https://img.shields.io/badge/Free_for_Non_Commercial_Use-brightgreen)](#-license)

⭐ **Star us on GitHub** — it motivates us a lot!

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screenshots & Demo](#-screenshots--demo)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
  - [Clone Repository](#-clone-repository)
  - [Configure PostgreSQL](#-configure-postgresql)
  - [Populate Database](#-populate-database)
  - [Set Up Python Environment](#-set-up-python-environment)
  - [Set Environment Variables](#-set-environment-variables)
  - [Start the Application](#-start-the-application)
- [Usage](#-usage)
- [Contributing](#-contributing)
- [License](#-license)

## 🏁 Introduction

GroceryMate is an application developed as part of the Masterschools program by **Alejandro Roman Ibanez**. It is a modern, full-featured e-commerce platform designed for seamless online grocery shopping. It provides an intuitive user interface and a secure backend, allowing users to browse products, manage their shopping basket, and complete purchases efficiently.

GroceryMate is a modern, full-featured e-commerce platform designed for seamless online grocery shopping. It provides an intuitive user interface and a secure backend, allowing users to browse products, manage their shopping basket, and complete purchases efficiently.

For details about the application's features, functionality, and local installation, refer to the original [`README.md`](APPLICATION.md) by Alejandro.

This document focuses exclusively on the AWS infrastructure, deployment process, and automation.

## 🚀 Overview
This project demonstrates how to deploy a simple web application on AWS using Terraform.
The infrastructure includes an EC2 instance for the application, an RDS PostgreSQL database, and an S3 bucket for file storage.

## 🏗️ Infrastructure 

- **VPC**: with public and private subnets.
- **EC2 Instance**: (Amazon Linux 2) to run the Grocery app.
- **RDS (PostgreSQL)**: in private subnets.
- **S3 Bucket**: for storing images/files.
- **Security Groups**: to allow
  - SSH & HTTP access to EC2.
  - PostgreSQL access only from EC2.
 
## 🛠️ Terraform configuration
```
/infrastructure
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars
│── S3.tf
└── README.md
```

## 📸 Screenshots & Demo

![imagen](https://github.com/user-attachments/assets/ea039195-67a2-4bf2-9613-2ee1e666231a)

![imagen](https://github.com/user-attachments/assets/2772b85e-81f7-446a-9296-4fdc2b652cb7)

https://github.com/user-attachments/assets/d1c5c8e4-5b16-486a-b709-4cf6e6cce6bc

## 📋 Prerequisites
- **AWS account**
- **AWS CLI installed & configured (aws configure)**
- **Terraform installed (v1.5+)**
- **SSH key pair in AWS (for EC2 access)**

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

### 🔹 Apply the configuration
```sh
terraform apply -auto-approve
```

### 🔹 Access the application
```sh
terraform output
```

# 🛠️ Variables

|       Variable       |      Description       |   Default     |
|----------------------|------------------------|---------------|
| `instance_type`      | EC2 instance type      | `t2.micro`    |
| `db_username`        | RDS username           | `postgres`    |
| `db_password`        | RDS password           | set manually  |
| `vpc_cidr`           | VPC CIDR block         | `10.10.0.0/16`|
| `public_subnet_cidr` | Public subnet CIDR     | `10.10.1.0/24`|
| `private_subnet1_cidr` | Private subnet 1 CIDR | `10.10.2.0/24`|
| `private_subnet2_cidr` | Private subnet 2 CIDR | `10.10.3.0/24`|

**🧹 Cleanup**

To avoid unnecessary AWS costs, destroy resources when not needed:
```sh
terraform destroy -auto-approve
```
Update `.env`:

```sh
nano .env
```

Fill in the following information (make sure to replace the placeholders):

```ini
JWT_SECRET_KEY=<your_generated_key>
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=localhost
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}
```

### 🔹 Start the Application

```sh
python3 run.py
```

## 📊 Cost Considerations

- **EC2**: Free tier eligible (t2.micro)

- **RDS**: Costs may apply (db.t3.micro ~ free tier for 12 months)

- **S3**: Low cost, pay per storage and requests

## 📷 Architecture Diagram
## ✅ Summary
This project shows how to deploy a cloud-based application with Terraform on AWS.
You learned how to provision networking, compute, database, and storage resources in a reproducible way. 

## 📜 License

This project is licensed under the MIT License.




