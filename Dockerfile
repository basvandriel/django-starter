FROM python:3.14-slim AS builder

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

# Install dependencies into an isolated virtualenv
COPY pyproject.toml ./
RUN uv sync --no-dev --no-install-project

# --- runtime stage ---
FROM python:3.14-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app

# Copy the virtualenv from builder
COPY --from=builder /app/.venv .venv

# Copy project source
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["python", "-m", "gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "2"]
