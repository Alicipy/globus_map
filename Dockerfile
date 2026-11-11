FROM nginxinc/nginx-unprivileged:1.31.7-alpine-slim@sha256:a8cb0f33d51fa107c96fd2bd3a71aaf564ec131e9d2bdf8700944f0ed8b170d7

COPY apps/nginx.conf /etc/nginx/conf.d/default.conf
COPY apps/index.html apps/main.css apps/main.js /usr/share/nginx/html/
COPY data/processed/deck.json /usr/share/nginx/html/data/processed/deck.json

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
