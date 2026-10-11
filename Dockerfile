FROM nginxinc/nginx-unprivileged:1.31.6-alpine-slim@sha256:1517d8c358e2e093957ebee087afa9eb19a32f5d7ecb711b7429e369cb998224

COPY apps/nginx.conf /etc/nginx/conf.d/default.conf
COPY apps/index.html apps/main.css apps/main.js /usr/share/nginx/html/
COPY data/processed/deck.json /usr/share/nginx/html/data/processed/deck.json

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
