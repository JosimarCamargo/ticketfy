FROM ruby:2.6.5-alpine3.10

# ARGS: RAILS_ENV, ENVIRONMENT_PACKAGES, COMMAND, RAILS_MASTER_KEY, RAILS_SERVE_STATIC_FILES

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
# if the variable isn't zero lenght, run the command, keep the variable between quotes to accept mult args
RUN if [ ! -z "$ENVIRONMENT_PACKAGES" ]; then apk add $ENVIRONMENT_PACKAGES; fi;

ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV

# redirect the logs to stdout
ENV RAILS_LOG_TO_STDOUT true

# gets the RAILS_MASTER_KEY, used at assets:precompile and don't keep it in any image layer
ARG RAILS_MASTER_KEY
RUN if [ $RAILS_ENV == 'production' ]; then rake assets:precompile; fi;

ARG RAILS_SERVE_STATIC_FILES
ENV RAILS_SERVE_STATIC_FILES $RAILS_SERVE_STATIC_FILES

# set CMD dinaminically, docker require that calls directly shell
ARG COMMAND
ENV COMMAND $COMMAND
CMD [ "sh", "-c", "${COMMAND}"]
EXPOSE 3000
