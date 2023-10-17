FROM ruby:2.2.10-alpine
RUN apk update --no-cache && apk add --no-cache ruby ruby-dev ruby-bundler build-base

# Здесь должно быть это, но оно не работает! Потому останется как есть.
# FROM ubuntu:16.04
# RUN apt-get update \
#     && apt-get install -y ruby-full ruby-dev build-essential \
#     && gem install bundler --no-ri --no-rdoc
# p.s. установка bundler вываливается с ошибкой
# ставится версия руби 2.5, а бандлеру нужна версия >=2.6
# я пытался поставить совместимую версию бандлера 2.3.26
# но в этом случае не выполняется команда RUN bundle install
# в общем нет сейчас ни смысла ни времени разбираться с приколюхами руби
# я с этим стеком никогда не работал

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
