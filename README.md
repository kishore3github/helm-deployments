Repository for Helm deployments.

## Overview

This repository contains Helm charts and deployment templates to help you manage Kubernetes applications efficiently. It includes charts for PostgreSQL, two API services, and a frontend service named `my-service`. Each service is equipped with its own continuous deployment (CD) workflow. Additionally, there is a consolidated workflow to trigger deployments either sequentially or in parallel.

Helm simplifies the process of packaging, configuring, and deploying applications and services onto Kubernetes clusters.

## Consolidated Optimised Deployment Pipeline

This repository contains a GitHub Actions workflow (`consolidated_deployment.yaml`) that automates the deployment of multiple services defined in a `consolidated-deployments.yaml` file. The workflow is designed to trigger reusable deployment workflows for each service group in parallel, wait for their completion, and handle errors gracefully.

### How It Works

- **Trigger:** The workflow runs on every push to the `main` branch that modifies `consolidated-deployments.yaml`.
- **Service Groups:** It reads the `Deployments` array from `consolidated-deployments.yaml`, where each item is a group of services.
- **Parallel Execution:** For each group, it triggers deployments for all services in parallel using the GitHub CLI (`gh`).
- **Reusable Workflows:** Each service triggers a specific reusable workflow (e.g., `list_team.yaml`, `my_service.yaml`, etc.) based on its name.
- **Run Tracking:** The workflow collects run IDs for each triggered deployment and waits for all runs in a group to finish before proceeding.
- **Error Handling:** If any deployment fails, the workflow stops and reports the error.

### Prerequisites

- A valid `consolidated-deployments.yaml` file in the repository root.
- GitHub repository secrets:
    - `PERSONAL_ACCESS_TOKEN`: A GitHub token with `workflow` permissions.
- The reusable workflows (`list_team.yaml`, `my_service.yaml`, etc.) must exist in your repository.

### Usage

1. **Define Deployments:**  
     Create or update `consolidated-deployments.yaml` with your service groups and their details.

2. **Push Changes:**  
     Commit and push your changes to the `main` branch.

3. **Monitor Workflow:**  
     The workflow will automatically run, triggering deployments for each group and waiting for their completion.

### Example `consolidated-deployments.yaml`

- The file is designed for use in CI/CD pipelines to automate deployments across multiple environments.
- It supports dry-run mode to validate configurations without performing actual deployments.
- Services within each group are deployed in parallel, while groups themselves are processed sequentially.
```yaml
Deployments:
    - database:
            - name: postgres
                image: v3
                namespace: development
                flyway: false
    - backend:
            - name: add-team
                image: v1
                namespace: development
                flyway: true
    - frontend:
            - name: my-service
                image: v1
                namespace: development
                flyway: false
```


## Features

- Predefined Helm charts for PostgreSQL, two API services, and a frontend service
- Individual CD workflows for each service
- Consolidated workflow for sequential and parallel deployments
- Easy customization through values files
- Version-controlled deployment templates
- Support for multiple environments (dev, staging, production)

## Getting Started

1. **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd helm-deployments
    ```

2. **Install Helm (if not already installed):**
    [Helm Installation Guide](https://helm.sh/docs/intro/install/)

3. **Deploy a chart:**
    ```bash
    helm install <release-name> ./charts/<chart-name> -f values/<env>.yaml
    ```

## Directory Structure

```
helm-deployments/

|── postgres/
|── list-team/
|── add-team/
│── my-service/
├── values/
│   └── <env>.yaml
├── templates/
├── .github/
│   └── workflows/
│       ├── add_team.yaml
│       ├── list_team.yaml
│       ├── postgres.yaml
│       └── consolidated-deployment.yaml
└── README.md
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements or bug fixes.

## License

This project is licensed under the MIT License.