FROM python:3.12-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIPENV_VENV_IN_PROJECT=1
ENV PORT=3000

FROM base AS builder
WORKDIR /
RUN pip install --no-cache-dir pipenv
COPY Pipfile* .
RUN pipenv sync

FROM base
RUN useradd --uid 1000 --no-create-home \
    --home-dir /nonexistent --shell /usr/sbin/nologin app

COPY --from=builder /.venv /.venv
ENV PATH=/.venv/bin:$PATH
WORKDIR /app
COPY . .

USER app
EXPOSE ${PORT}
CMD ["sh", "./run.sh"]
