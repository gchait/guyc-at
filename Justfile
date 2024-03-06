export PIPENV_VENV_IN_PROJECT := "1"
export REPO := "gchait/guyc-at"
export PORT := "3000"

fmt:
    pipenv run ruff format .

lint:
    pipenv run ruff check --fix .

test:
    pipenv run pytest .

dev: fmt lint
    SITE_ADDRESS=localhost docker compose up -d

prod:
    SITE_ADDRESS=guyc.at docker compose up -d

push MSG: test
    docker compose build --push
    git add -A
    git commit -m "{{MSG}}"
    git push origin

deploy:
    ssh prod "cd guyc-at && git pull && just prod"

prune:
    docker image prune -f

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
