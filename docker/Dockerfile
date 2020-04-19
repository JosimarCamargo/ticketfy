FROM ruby:2.6.5-alpine3.10

ARG environment_packages

RUN apk add --update build-base linux-headers bash git postgresql-dev \
  postgresql-client nodejs yarn curl tzdata

RUN gem install bundler:2.1.4

WORKDIR /app

# takes leverage the docker cache
COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs --jobs 4

COPY . .

# used to add packages like chromnium for test enviroment
RUN apk add $environment_packages

# redirect the logs to stdout
ENV RAILS_LOG_TO_STDOUT true

RUN rake assets:precompile

CMD puma -C config/puma.rb

EXPOSE 3000
