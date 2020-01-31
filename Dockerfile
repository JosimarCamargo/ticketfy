FROM josimarcamargo/ticketfy:base

COPY --from=josimarcamargo/ticketfy:gem_cache  /vendor/bundler  /vendor/bundler

WORKDIR /application

COPY . .

# install not cached gems and clean temporary gem extensions written in C
RUN bundle install --path=/vendor/bundler --deployment --jobs 4 --retry 3 \
  && rm -rf /gems/cache/*.gem

# redirect the logs stdout in production
ENV RAILS_LOG_TO_STDOUT true

ENV RAILS_SERVE_STATIC_FILES true

ARG RAILS_ENV

ARG RAILS_MASTER_KEY

RUN rake assets:precompile

CMD bundle exec rails s -b 0.0.0.0

EXPOSE 3000
