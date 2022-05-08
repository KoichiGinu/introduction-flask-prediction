FROM python:3.9-slim-buster as prod

RUN apt-get update && apt-get upgrade -y
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# OpenCV
RUN apt-get install -y libgl1-mesa-glx libgl1-mesa-dev libglib2.0-0 libsm6 libxrender1 libxext6

# pip
WORKDIR /opt/app
COPY Pipfile Pipfile.lock /opt/app/
RUN pip install pipenv \
  && pipenv install --ignore-pipfile --deploy --system

# WORKDIR
WORKDIR /opt/app
COPY . /opt/app

# clearn
RUN rm -rf /var/lib/apt/lists/*

CMD exec gunicorn --bind :80 --workers 1 --threads 8 --timeout 0 app:app
