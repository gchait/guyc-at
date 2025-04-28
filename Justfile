dev: build
  docker compose up -d

prod: build
  SITE_ADDRESS=guyc.at docker compose up -d

deploy MSG:
  git add -A
  git commit -m "{{MSG}}"
  git push origin
  ssh prod "cd guyc-at && git pull && just prod prune"

build:
  mkdir -p ./caddy/data ./caddy/config
  rm -rf ./site/public/*
  hugo --quiet --minify -s ./site
  docker compose pull

prune:
  docker image prune -f

stop: prune
  docker compose stop
  docker container prune -f

cert:
  docker compose cp \
    caddy:/data/caddy/pki/authorities/local/root.crt \
    ./caddy/localhost.crt
