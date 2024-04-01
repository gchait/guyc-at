export PROD_HOST := "guyc.at"

dev: pull    
    docker compose up -d

prod: pull
    SITE_ADDRESS={{PROD_HOST}} docker compose up -d

push MSG:
    git add -A
    git commit -m "{{MSG}}"
    git push origin

pull:
    docker compose pull

prune:
    docker image prune -f

deploy:
    ssh prod "cd guyc-at && git pull && just prod prune"

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
