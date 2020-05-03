FROM ruby:2.6.5-alpine3.10

# ARGS: RAILS_ENV, ENVIRONMENT_PACKAGES, both are optional

RUN apk add --update build-base linux-headers bash git postgresql-dev \
  postgresql-client nodejs yarn curl tzdata

RUN gem install bundler:2.1.4

WORKDIR /app

# takes leverage the docker cache
COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs --jobs 4

COPY . .

# used to add packages like chromnium for test enviroment
ARG ENVIRONMENT_PACKAGES
# if the variable isn't zero lenght, run the command, keep the variable between quotes, to accept mult args
RUN if [ ! -z "$ENVIRONMENT_PACKAGES" ]; then apk add $ENVIRONMENT_PACKAGES; fi;

ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV

# redirect the logs to stdout
ENV RAILS_LOG_TO_STDOUT true

RUN if [ RAILS_ENV = 'production' ]; then rake assets:precompile; fi;

CMD rails s -b 0.0.0.0

EXPOSE 3000
