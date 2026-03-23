dev:
	uv run python manage.py runserver

migrate:
	uv run python manage.py migrate

run-from-docker:
	docker build -t django-starter .
	docker run -p 8000:8000 django-starter