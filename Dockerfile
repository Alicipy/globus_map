FROM python:3.12-slim

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

CMD uv run panel serve --port $PORT 10_visualize_map.ipynb
