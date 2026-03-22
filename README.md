# CI/CD Pipeline Automation — Jenkins & GitHub Actions

Dual CI/CD pipeline implementation automating build, test, and deployment workflows for a containerized application. Demonstrates end-to-end pipeline design with automated testing gates, Docker image management, and deployment automation — built to mirror the CI/CD modernization work done in enterprise financial services environments.

## Pipeline Overview

### Jenkins Pipeline
```
Checkout → Build → Unit Tests → Docker Build → Push to Registry → Deploy → Smoke Test
```

### GitHub Actions Pipeline
```
Lint → Unit Tests → Integration Tests → Docker Build → Push → Deploy
       └── (parallel jobs) ──────────────┘
```

## Repo Structure

```
cicd-pipeline-lab/
├── jenkins/
│   └── Jenkinsfile             # Declarative Jenkins pipeline
├── github-actions/
│   └── .github/workflows/
│       ├── ci.yml              # PR validation pipeline
│       └── cd.yml              # Main branch deployment pipeline
├── app/
│   ├── src/                    # Sample Python Flask application
│   └── tests/                  # Unit and integration tests
├── docker/
│   └── Dockerfile              # Multi-stage Docker build
└── scripts/
    ├── run-tests.sh            # Local test runner
    └── deploy.sh               # Deployment script
```

## Key Features

- **Dual pipeline** — Jenkins for on-prem/hybrid, GitHub Actions for cloud-native
- **Automated quality gates** — deployment blocked on test failure
- **Multi-stage Docker builds** — minimal production images
- **Git SHA tagging** — every image traceable to exact commit
- **Secret management** — no hardcoded credentials anywhere
- **S3 artifact versioning** — rollback-capable deployments
- **Webhook integration** — automatic pipeline trigger on push

## Running Locally

```bash
# Install dependencies
pip install -r app/requirements.txt

# Run tests
./scripts/run-tests.sh

# Build Docker image
docker build -f docker/Dockerfile -t sample-app:local .

# Run container
docker run -p 5000:5000 sample-app:local
```

## Author

**Djamal Tighilt Ferhat** — DevOps & Cloud Engineer
[github.com/dtighiltferhat](https://github.com/dtighiltferhat)
