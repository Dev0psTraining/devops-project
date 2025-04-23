# DevOps Pipeline Project

A simplified DevOps pipeline for an ASP.NET Core web application, built for a local environment without using Docker or cloud platforms.

## Project Description

This project demonstrates DevOps principles including:
- Version control with Git
- Continuous Integration with GitHub Actions
- Infrastructure as Code with Ansible
- Blue-Green deployment for zero-downtime updates
- Health monitoring and logging
- Rollback capabilities

## Technologies Used

- **Web Application**: ASP.NET Core 7.0
- **Testing**: xUnit and Moq
- **Version Control**: Git and GitHub
- **CI/CD**: GitHub Actions
- **IaC**: Ansible
- **Deployment Strategy**: Blue-Green deployment
- **Health Checks**: Bash scripts using curl

## Project Structure

```
devops-project/
├── .github/
│   └── workflows/
│       └── ci-cd.yml       # GitHub Actions CI/CD pipeline
├── WebApp/                 # ASP.NET Core application
├── WebApp.Tests/           # Unit tests for the application
├── ansible/                # Infrastructure as Code
│   ├── inventory.ini       # Ansible inventory
│   └── deploy.yml          # Ansible playbook for deployment
├── deploy.sh               # Deployment script
├── rollback.sh             # Rollback script
├── health_check.sh         # Health monitoring script
├── production/             # Production environment
│   ├── blue/               # Blue deployment slot
│   ├── green/              # Green deployment slot
│   └── active -> blue/     # Symlink to active deployment
└── README.md               # Documentation
```

## CI/CD Pipeline Workflow

1. **Development**:
   - Code is developed on the `dev` branch
   - Pull requests are created to merge changes into `main`

2. **Continuous Integration**:
   - GitHub Actions runs on every push to `dev` and `main`
   - Builds the application and runs tests
   - Generates deployment artifacts for `main` branch

3. **Continuous Deployment**:
   - Ansible playbook deploys the application using Blue-Green strategy
   - The deployment script manages the process and starts the application
   - Health checks verify the application is running correctly

4. **Monitoring**:
   - Health checks run periodically and log results
   - Automatic rollback can be enabled if health check fails

## Setup and Usage Instructions

### Prerequisites
- .NET SDK 7.0
- Git
- Ansible
- GitHub account

### Setup

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/devops-project.git
   cd devops-project
   ```

2. Make deployment scripts executable:
   ```
   chmod +x deploy.sh rollback.sh health_check.sh
   ```

3. Run the initial deployment:
   ```
   ./deploy.sh
   ```

4. Access the application at `http://localhost:5000`

### Workflow

1. Create a feature branch from `dev`:
   ```
   git checkout dev
   git checkout -b feature/new-feature
   ```

2. Make your changes and commit:
   ```
   git add .
   git commit -m "Add new feature"
   ```

3. Push your branch and create a PR to `dev`:
   ```
   git push origin feature/new-feature
   ```

4. After PR approval and merge to `dev`, create a PR from `dev` to `main`

5. After merge to `main`, the CI/CD pipeline will automatically build and create artifacts

6. Run deployment manually:
   ```
   ./deploy.sh
   ```

7. If issues arise, rollback using:
   ```
   ./rollback.sh
   ```

## Blue-Green Deployment Strategy

This project implements a Blue-Green deployment strategy:

1. Two identical environments: Blue and Green
2. Only one environment is active at a time
3. New deployments go to the inactive environment
4. After health checks pass, traffic is switched to the new environment
5. This enables zero-downtime deployments and easy rollbacks

## Workflow Diagram

```
Development -> CI (GitHub Actions) -> Build Artifacts -> Deploy (Ansible) -> Health Check -> Active Production
                                                                      ↑
                                                                      |
                                      Rollback <-- Failed Health Check
```

## Screenshots

*Add screenshots of your CI/CD pipeline, deployments, and the running application here*