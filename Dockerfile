FROM python:3.6

RUN pip install --upgrade -q \
pip \

ENV LOG_LEVEL WARNING

COPY app /app
WORKDIR /app

RUN pip install --upgrade
