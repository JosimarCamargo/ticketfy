# This Dockerfile are being deprecated
FROM ruby:2.6.1-alpine3.9

RUN apk add --no-cache --update build-base \
  linux-headers \
  git \
  postgresql-dev \
  nodejs \
  tzdata

WORKDIR /application

COPY Gemfile* ./

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

CMD rails s -b 0.0.0.0

COPY . ./
EXPOSE 3000
