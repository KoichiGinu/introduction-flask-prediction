deploy:
	sh deploy.sh

start-server:
	gunicorn --bind :80 --workers 1 --threads 8 --timeout 0 app:app
