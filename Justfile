dev: align
    docker compose up -d

prod: align
    SITE_ADDRESS=guyc.at docker compose up -d

deploy MSG:
    git add -A
    git commit -m "{{MSG}}"
    git push origin
    ssh prod "cd guyc-at && git pull && just prod prune"

align:
    mkdir -p ./caddy/data ./caddy/config
    docker compose pull

prune:
    docker image prune -f

stop:
    docker compose stop
    docker container prune -f

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
