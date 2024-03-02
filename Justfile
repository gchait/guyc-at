start:
    docker compose up -d

stop:
    docker compose down

cert:
    docker compose cp caddy:/data/caddy/pki/authorities/local/root.crt .
