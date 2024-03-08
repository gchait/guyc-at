export REPO := "gchait/guyc-at"
export SRC := "guyc_at"
export PORT := "3000"

fmt:
    dart format {{SRC}}

lint:
    dart analyze {{SRC}}

test:
    cd {{SRC}} && dart test

dev: fmt lint
    docker compose build
    SITE_ADDRESS=localhost docker compose up -d

prod:
    docker compose pull
    SITE_ADDRESS=guyc.at docker compose up -d

push MSG: test
    docker compose build --push
    git add -A
    git commit -m "{{MSG}}"
    git push origin

prune:
    docker image prune -f

deploy:
    ssh prod "cd guyc-at && git pull && just prod prune"

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
