FROM python:3.6.0-alpine

WORKDIR /app
COPY VERSION *.py requirements.txt VERSION ./

RUN apk --no-cache --update add build-base \
    && pip install --upgrade pip \
    && pip install -r /app/requirements.txt
RUN apk --no-cache --update add bash vim iputils \
    && apk del build-base

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

CMD ["python3", "post_app.py"]
