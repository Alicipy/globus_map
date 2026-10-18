FROM nginxinc/nginx-unprivileged:1.31.7-alpine-slim@sha256:b94a56c52fd315bbd8f1f4368d64c25983351c978313e02feff2c0b35e856f2d

COPY apps/nginx.conf /etc/nginx/conf.d/default.conf
COPY apps/index.html apps/main.css apps/main.js /usr/share/nginx/html/
COPY data/processed/deck.json /usr/share/nginx/html/data/processed/deck.json

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
