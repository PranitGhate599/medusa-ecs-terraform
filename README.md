# Medusa.js on AWS ECS (Terraform + GitHub Actions)

This repository provisions a headless commerce backend using **Medusa.js**, deployed on **AWS ECS with Fargate**, with a fully automated **CI/CD pipeline** using **GitHub Actions**.

---

## 🧾 What’s Inside

- `terraform/`
  - `variables.tf`, `main.tf`, `ecs.tf`, `rds.tf`, `outputs.tf`: Terraform configuration files
  - Creates VPC, RDS PostgreSQL, ECS Cluster, IAM roles, ECR repo, and more
- `Dockerfile`: Builds & starts the Medusa backend
- `.github/workflows/deploy.yml`: GitHub Actions CI/CD that builds, tags, pushes image to ECR, and deploys to ECS

---

## ⚙️ Setup Instructions

### 1. Prerequisites
- AWS account with suitable IAM permissions (ECR, ECS, RDS, IAM)
- GitHub repository with secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - (or `AWS_DEPLOY_ROLE` if using OIDC or role assumption)
- Installed:
  - Terraform 1.x
  - AWS CLI
  - Docker

### 2. Configure Terraform Variables
Edit **`terraform/variables.tf`** and create a `terraform.tfvars` file with:

```ini
aws_region      = "us-east-1"
project         = "medusa-shop"
environment     = "prod"

db_name         = "medusa_store"
db_user         = "admin"
db_password     = "StrongPass123"
db_port         = 5432

ecr_image_url   = "123456789012.dkr.ecr.us-east-1.amazonaws.com/medusa-backend:latest"

fargate_cpu     = "1024"
fargate_memory  = "2048"

jwt_secret      = "YourJWTSecret"
cookie_secret   = "YourCookieSecret"
auth_cors       = "https://shop.example.com"
store_cors      = "https://shop.example.com"
admin_cors      = "https://admin.example.com"
redis_url       = "redis://?:password@redis-host:6379"
medusa_worker_mode = "server"
````

### 3. Apply Terraform

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

Outputs such as `database_url`, `ecs_service_name`, `load_balancer_dns`, etc., will be printed and can be accessed using `terraform output`.

---

## 🚀 GitHub Actions CI/CD

Trigger: Push to `main` branch.

The workflow:

* Checks out your code
* Builds Docker image
* Tags the image with Git commit SHA
* Pushes to ECR
* Deploys via ECS Actions:

  * `amazon-ecs-render-task-definition`
  * `amazon-ecs-deploy-task-definition`

You’ll need to set repository-level environment variables in the workflow:

* `AWS_REGION`, `ECR_REPOSITORY`, `ECS_CLUSTER`, `ECS_SERVICE`, `CONTAINER_NAME`

---

## 📄 Example Directory Structure

```
/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── ecs.tf
│   ├── rds.tf
│   └── outputs.tf
├── Dockerfile
├── medusa-config.js
├── .github/
│   └── workflows/
│       └── deploy.yml
└── README.md
```

---

## 💡 Tips & Notes

* **Sensitive data** such as `db_password`, `jwt_secret`, and `cookie_secret` are marked `sensitive = true` in Terraform to avoid log exposure.
* Use **SHA-based image tags** instead of `latest` to enable traceability and safe rollbacks.
* Ensure your CPU and memory combinations for Fargate are valid (e.g., 1024 CPU with at least 2048 MiB memory) ([YouTube][1], [GitHub][2], [YouTube][3], [Medium][4], [LinkedIn][5]).
* You can optionally leverage Terraform modules (such as the community Medusa module `u11d-com/terraform-u11d-medusajs`) to simplify setup ([GitHub][6]).

---

## 🚧 Troubleshooting & Resources

* **Invalid CPU/memory combos**: Refer to AWS Fargate task definition limits to ensure supported values .
* **Medusa setup issues**: Commonly related to malformed `DATABASE_URL` or missing secrets. Confirm your URL follows:

  ```
  postgres://user:password@host:port/dbname
  ```
* **CORS errors**: Validate origin URL formats in `auth_cors`, `store_cors`, `admin_cors`.

---

## 📚 Additional References

* Medusa.js official deployment guide: setup backend with Postgres & Redis
* Terraform ECS + Fargate examples
* GitHub Actions for ECS deployment best practices

---