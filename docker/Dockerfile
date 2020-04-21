FROM ruby:2.6.5-alpine3.10

# ARGS: RAILS_ENV, environment_packages, both are optional

RUN apk add --update build-base linux-headers bash git postgresql-dev \
  postgresql-client nodejs yarn curl tzdata

RUN gem install bundler:2.1.4

WORKDIR /app

# takes leverage the docker cache
COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs --jobs 4

COPY . .

# used to add packages like chromnium for test enviroment
ARG environment_packages
# if the variable isn't zero lenght, run the command
RUN if [ ! -z $environment_packages ]; then apk add $environment_packages; fi;

ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV

# redirect the logs to stdout
ENV RAILS_LOG_TO_STDOUT true

RUN if [ RAILS_ENV = 'production' ]; then rake assets:precompile; fi;

CMD rails s -b 0.0.0.0

EXPOSE 3000
