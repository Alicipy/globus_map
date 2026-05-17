FROM python:3.14-slim

ENV PORT=54721
ENV PYTHONUNBUFFERED=1

EXPOSE ${PORT}

WORKDIR /app
RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
RUN uv sync --no-cache-dir

COPY data/processed/ ./data/processed/
COPY apps/ ./apps/

WORKDIR /app/apps

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD python -c "from urllib.request import urlopen; import os; urlopen(f'http://localhost:{os.environ[\"PORT\"]}/10_visualize_map', timeout=5)"

CMD uv run panel serve --global-loading-spinner --port $PORT 10_visualize_map.ipynb
