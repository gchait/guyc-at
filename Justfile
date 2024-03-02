dev:
    SITE_ADDRESS=localhost docker compose up -d

prod:
    SITE_ADDRESS=guyc.at docker compose up -d

deploy:
    ssh prod "cd guyc-at && git pull && just prod"

bye:
    docker compose down

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
