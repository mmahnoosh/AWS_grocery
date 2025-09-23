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
- [🛒 Features](#-Features)
- [🏗️ Architecture & Approach](#architecture--approach)
- [🛠️ Terraform Layout](#terraform-layout)
- [📸 Screenshots & Demo](#-screenshots--demo)
- [📋 Prerequisites](#-prerequisites)
- [🚀 Deployment Steps](#-deployment-steps)
- [🐘 PostgreSQL Setup](#-PostgreSQLSetup)
- [⚙️ Configuration Variables](#️-configuration-variables)
- [🧹 Cleanup](#-cleanup)
- [🔧 Environment Variables](#-environment-variables)
- [▶️ Run the Application](#️-run-the-application)
- [💰 Cost Considerations](#-cost-considerations)
- [✅ Summary](#-summary)
- [🧑‍💻 Contributing](#-contributing)
- [📜 License](#-license)
  
## 📖 Introduction

GroceryMate is an application developed as part of the Masterschools program by **Alejandro Roman Ibanez**. It is a modern, full-featured e-commerce platform designed for seamless online grocery shopping. It provides an intuitive user interface and a secure backend, allowing users to browse products, manage their shopping basket, and complete purchases efficiently.

GroceryMate is a modern, full-featured e-commerce platform designed for seamless online grocery shopping. It provides an intuitive user interface and a secure backend, allowing users to browse products, manage their shopping basket, and complete purchases efficiently.

> This document focuses exclusively on the AWS infrastructure, deployment process, and automation.
> For details about the application's features, functionality, and local installation, refer to the original [`README.md`](APPLICATION.md) by Alejandro.


## 🛒 Features

- **🛡️ Authentication**: Secure login & session management
- **🔒 Protected Routes**: Access control for authenticated users
- **🔎 Product Search & Filtering**: Browse products, apply filters, and sort by category or price.
- **⭐ Favorites Management**: Save preferred products.
- **🛍️ Shopping Basket**: Add, view, modify, and remove items.
- **💳 Checkout Process**: with billing, shipping & payments

  
## 🏗️ Architecture & Approach

We use AWS Lambda + API Gateway for a serverless backend:

- No server management
- Pay-per-execution
- Automatic scaling

All infrastructure is deployed with Terraform, ensuring reproducibility and maintainability.


## 📷 Architecture Diagram

<img width="1101" height="867" alt="MyDiagram drawio" src="https://github.com/user-attachments/assets/e2c26374-2b2b-42bf-9dc6-e94990dab4ea" />



### Components

- Amazon API Gateway – entry point for requests
- AWS Lambda – executes backend logic
- Amazon RDS (PostgreSQL) – relational database
- Amazon S3 – static assets & avatar storage (versioning enabled)
- Amazon CloudWatch – monitoring & logging
- IAM Roles – secure permission handling
- VPC & Security Groups – controlled network access

---

## 🛠️ Terraform Layout

```text
/infrastructure
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars
│── S3.tf
├─ Lambda/                
└─ serverless/
   └─ infra/
       ├─ main.tf
       ├─ variables.tf
       └─ outputs.tf
└── README.md

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
## AWS RDS Setup

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

### 🔹 Run the Application

```bash
python3 run.py
```

## 📊 Cost Considerations

- **Lambda**: very low (pay per request)
- **RDS**: db.t3.micro (~ free tier 12 months)
- **S3**: Low cost, pay per storage and requests
- **CloudWatch**: pay per log volume

## ✅ Summary
This project demonstrates a serverless cloud deployment with AWS + Terraform.
You provisioned networking, database, storage, and monitoring in a reproducible way.

## 🧑‍💻 Contributing

Contributions, issues, and feature requests are welcome!  
Here’s how you can contribute:

1. **Fork** the repository  
2. Create a new branch:  
   ```bash
   git checkout -b feature/your-feature


## 📜 License

This project is licensed under the MIT License.
