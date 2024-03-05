#!/bin/sh

uvicorn app.main:app \
    --no-server-header \
    --proxy-headers \
    --host '0.0.0.0' \
    --port "${PORT}"
