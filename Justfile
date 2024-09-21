PROD_HOST := `ssh -G prod | awk '$1 == "hostname" { print $2 }'`

dev: pull    
    docker compose up -d

prod: pull
    SITE_ADDRESS="{{PROD_HOST}}" docker compose up -d

deploy MSG:
    git add -A
    git commit -m "{{MSG}}"
    git push origin
    ssh prod "cd guyc-at && git pull && just prod prune"

stop:
    docker compose stop
    docker container prune -f

pull:
    docker compose pull

prune:
    docker image prune -f

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
