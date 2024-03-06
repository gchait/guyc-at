#!/bin/sh -ex

uvicorn guyc_at.main:app \
    --no-server-header \
    --proxy-headers \
    --host '0.0.0.0' \
    --port "${PORT}"
