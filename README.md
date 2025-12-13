# PulseCheck

PulseCheck is a minimal FastAPI-based health check service designed for DevOps and cloud-native learning.

## Purpose
This project demonstrates:
- A simple production-style API
- Health endpoint for monitoring
- Container-ready application structure

## Run Locally (without Docker)

```bash
pip install -r requirements.txt
uvicorn app:app --host 0.0.0.0 --port 8000
```

## Health Endpoint

```bash
GET /health
```

Response:

```json
{
    "status": "ok"
}
```

## Tech Stack
- Python
- FastAPI
- Uvicorn
- Docker

## Common Mistakes
- Overwriting README later (breaks history clarity)
- Writing vague descriptions
- Missing run instructions

## Checkpoint (MANDATORY)

Run:

```powershell
cat README.md
```
