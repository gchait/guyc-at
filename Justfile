export PIPENV_VENV_IN_PROJECT := "1"

dev: fmt
    SITE_ADDRESS=localhost docker compose up -d --build

prod:
    SITE_ADDRESS=guyc.at docker compose up -d

fmt:
    pipenv run ruff format .

lint:
    pipenv run ruff check --fix .
    pipenv run mypy --pretty .

test:
    pipenv run pytest .

deploy: lint test
    ssh prod "cd guyc-at && git pull && just prod"

bye:
    docker compose down

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
