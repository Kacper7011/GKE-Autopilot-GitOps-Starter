import os
import time
from fastapi import FastAPI
from datetime import datetime

APP_VERSION = "0.1.5"  # <-- TU ŚWIADOMIE ZMIENIASZ W KOLEJNYCH RELEASE'ACH
START_TIME = datetime.utcnow()

app = FastAPI(
    title="FastAPI GitOps Demo",
    description="Demo aplikacji do testów GitOps + ArgoCD",
    version=APP_VERSION,
)

@app.get("/")
def read_root():
    return {
        "message": "Hello from GKE Autopilot 🚀",
        "app_version": APP_VERSION,
        "pod_name": os.getenv("POD_NAME", "unknown"),
        "project_id": os.getenv("PROJECT_ID", "unknown"),
        "started_at_utc": START_TIME.isoformat() + "Z",
        "uptime_seconds": int((datetime.utcnow() - START_TIME).total_seconds()),
    }

@app.get("/health/live")
def liveness():
    return {
        "status": "alive",
        "timestamp": datetime.utcnow().isoformat() + "Z",
    }

@app.get("/health/ready")
def readiness():
    return {
        "status": "ready",
        "checks": {
            "config_loaded": True,
            "dependencies_ok": True,
        },
    }

@app.get("/config")
def config_preview():
    """
    Endpoint pomocny do debugowania środowiska uruchomieniowego
    """
    return {
        "env": {
            "POD_NAME": os.getenv("POD_NAME"),
            "PROJECT_ID": os.getenv("PROJECT_ID"),
            "ENV": os.getenv("ENV", "production"),
        }
    }

@app.get("/feature/experimental")
def experimental_feature():
    """
    Ten endpoint jest idealny do testów:
    - w kolejnej wersji możesz zmienić response
    - albo go usunąć
    """
    return {
        "feature": "experimental",
        "enabled": True,
        "note": "This feature exists only in version 0.1.5+",
    }

