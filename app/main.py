import os
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {
        "message": "Hello from GKE Autopilot!",
        "pod_name": os.getenv("POD_NAME", "unknown"),
        "project_id": os.getenv("PROJECT_ID", "unknown"),
    }

@app.get("/health/live")
def liveness():
    return {"status": "alive"}

@app.get("/health/ready")
def readiness():
    return {"status": "ready"}
