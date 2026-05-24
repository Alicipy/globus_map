FROM nginx:stable-alpine3.23-slim

COPY apps/nginx.conf /etc/nginx/conf.d/default.conf
COPY apps/index.html apps/main.css apps/main.js /usr/share/nginx/html/
COPY data/processed/deck.json /usr/share/nginx/html/data/processed/deck.json

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://localhost/healthz || exit 1
