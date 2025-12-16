from fastapi import FastAPI

app = FastAPI()

DEPLOY_VERSION = "PulseCheck v1.1 – deployed via CI/CD"

@app.get("/health")
def health():
    return {
        "status": "ok",
        "version": DEPLOY_VERSION
    }
