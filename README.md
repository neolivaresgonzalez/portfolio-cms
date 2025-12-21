# Portfolio CMS (Strapi)

This is the Strapi backend for the personal portfolio website.

## Infrastructure
The CMS is deployed on **AWS EC2 (Free Tier)** using a `t2.micro` instance.
- **OS**: Ubuntu 22.04 LTS
- **Runtime**: Node.js 20
- **Process Manager**: PM2
- **Database**: SQLite (stored locally on EBS volume)

## Deployment (CI/CD)
Deployment is automated via **GitHub Actions**.
1.  Pushing to `main` triggers the `Deploy CMS` workflow.
2.  The workflow connects to the EC2 instance via SSH.
3.  It pulls the latest code, installs dependencies, builds the admin panel, and restarts the PM2 process.

## Manual Infrastructure Provisioning
To set up the infrastructure (or restart from scratch):

1.  Navigate to `infra/`:
    ```bash
    cd infra
    ```
2.  Initialize and Apply Terraform:
    ```bash
    terraform init
    terraform apply
    ```
3.  **Important**: Note the `cms_public_ip` output.

## GitHub Secrets Configuration
The following repository secrets are required for the Deployment workflow:

- `CMS_EC2_HOST`: The Public IP address of the EC2 instance (from Terraform output).
- `CMS_EC2_SSH_KEY`: The **Private Key** matching the public key used in Terraform (`~/.ssh/portfolio-cms`).

## Local Development

1.  Install dependencies:
    ```bash
    npm install
    ```
2.  Start development server:
    ```bash
    npm run dev
    ```
