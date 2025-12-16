# 🚀 PulseCheck — CI/CD with Docker & AWS EC2

PulseCheck is a lightweight FastAPI-based health monitoring service built to **demonstrate real-world CI/CD principles**, Dockerized deployments, and SSH-based Continuous Deployment on AWS EC2 using GitHub Actions.

This project focuses on **proof of automation**, not just configuration.

---

## 🔍 Project Goals

* Build a simple health-check API (`/health`)
* Containerize the application using Docker
* Deploy on AWS EC2 (Free Tier)
* Implement **Continuous Deployment** using GitHub Actions
* Validate that deployments actually reach production
* Learn and document real-world DevOps failure scenarios

---

## 🧱 Tech Stack

* **Language**: Python
* **Framework**: FastAPI
* **Containerization**: Docker
* **Cloud**: AWS EC2 (Ubuntu LTS)
* **CI/CD**: GitHub Actions
* **Deployment Method**: SSH-based CD (no Kubernetes, no Terraform)

---

## 📁 Repository Structure

```
PulseCheck/
├── app.py                 # FastAPI application
├── Dockerfile             # Docker image definition
├── .github/
│   └── workflows/
│       ├── ci.yml         # CI: tests & health checks
│       └── cd.yml         # CD: deploy to EC2 via SSH
└── README.md
```

---

## ⚙️ Application Endpoints

### Health Check

```
GET /health
```

**Response:**

```json
{
  "status": "ok",
  "version": "PulseCheck v1.1 – deployed via CI/CD"
}
```

> The version marker is intentionally included to **prove real deployments**.

---

## 🧪 CI Pipeline (GitHub Actions)

**Triggered on:** Push to `main`

**What CI does:**

* Checks out code
* Installs dependencies
* Runs basic health validation
* Ensures app starts correctly

✅ CI must pass before CD executes

---

## 🚢 CD Pipeline (GitHub Actions → EC2)

**Triggered on:** Push to `main` (after CI)

### Deployment Flow

1. GitHub Actions sets up SSH securely
2. Connects to EC2 using a **dedicated deployment key**
3. Pulls latest code on EC2
4. Builds Docker image
5. Stops old container (if exists)
6. Runs new container with:

   * Port mapping
   * Restart policy
7. Application becomes live automatically

---

## 🔐 Security Highlights

* SSH access restricted to **My IP**
* EC2 access via key-based authentication only
* Secrets stored securely in GitHub Actions:

  * `EC2_HOST`
  * `EC2_USER`
  * `EC2_SSH_KEY`
  * `APP_PORT`

---

## ✅ Deployment Validation (Proof)

The deployment is considered successful only when:

* GitHub Actions CD pipeline turns **green**
* No manual SSH is used for deployment
* Browser shows **updated version string**
* Docker container restarts automatically
* Health endpoint responds correctly

Example:

```
http://<EC2_PUBLIC_IP>:8000/health
```

---

## ⚠️ What Went Wrong (Real Issues Faced)

This project intentionally documents **real failures**, because DevOps is about handling them.

### Common Issues Encountered

#### 1. Security Group Misconfiguration

* Port `8000` blocked → browser timeout
* Fixed by explicitly allowing `8000` from my IP

#### 2. SSH Key Confusion

* Mixed local SSH key vs GitHub Actions SSH key
* Learned to create **separate deployment keys**

#### 3. Docker Permission Errors

* `permission denied while trying to connect to docker.sock`
* Fixed by:

  ```bash
  sudo usermod -aG docker ubuntu
  ```

#### 4. Container Running but Not Accessible

* App bound to `localhost` instead of `0.0.0.0`
* Fixed in app / Docker configuration

#### 5. GitHub Secrets Formatting Errors

* Newlines in SSH private key broke authentication
* Learned that **secrets can fail silently**

#### 6. Pipeline Passed but App Didn’t Update

* Old container still running
* Container name mismatch (`pulsecheck` vs random name)
* Fixed by explicitly stopping & removing containers

#### 7. CD Pipeline Failed on Re-run

* `mkdir ~/.ssh` failed because directory existed
* Fixed by making steps **idempotent**

---

## 🧠 What I Learned (Key Takeaways)

### DevOps is About Validation, Not Assumptions

* Green pipeline ≠ successful deployment
* Browser-level verification is mandatory

### CI/CD Needs Proof Signals

* Version markers are essential
* Health endpoints are not optional

### Security is Layered

* Security Groups
* Network ACLs
* SSH keys
* Docker permissions

### Containers Can Lie

* `docker ps` is not enough
* You must check:

  * Logs
  * Image timestamps
  * Port bindings

### Failures Are Learning Assets

* Every failure improved pipeline robustness
* Documenting mistakes improved understanding

---

## 📌 Current Limitations (Known Gaps)

* No zero-downtime deployment strategy
* No rollback mechanism
* No HTTPS / Load Balancer
* No monitoring or alerting
* Single EC2 instance only

> These are **intentional exclusions** for learning clarity.

---

## 🎯 Future Improvements

* Add Nginx reverse proxy
* Implement blue-green or rolling deployments
* Add monitoring (Prometheus / CloudWatch)
* Introduce rollback strategy
* Migrate to Infrastructure as Code

---

## 🧑‍💻 Why This Project Matters

This project is not about perfection —
it’s about **proving that CI/CD actually works in production-like conditions**.

It reflects:

* Real mistakes
* Real debugging
* Real validation
* Real DevOps thinking

---

## 📄 License

MIT

