# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
# This image uses the latest version of Python 3.6
FROM python:3.6-slim-stretch

LABEL Name=sspanel Version=0.0.1

COPY . /src/django-sspanel

WORKDIR /src/django-sspanel

ENV LANG en_US.UTF-8

RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends \
        build-essential \
        python3-dev \
        default-libmysqlclient-dev vim cron syslog-ng && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get purge -qq -y build-essential python3-dev && \
    python3 manage.py collectstatic --no-input

