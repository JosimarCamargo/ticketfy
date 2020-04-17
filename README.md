# TicketFy

[![Build Status](https://semaphoreci.com/api/v1/ticketfy/ticketfy/branches/master/badge.svg)](https://semaphoreci.com/ticketfy/ticketfy)

[![Maintainability](https://api.codeclimate.com/v1/badges/c8f29240ac491a6cfb03/maintainability)](https://codeclimate.com/github/JosimarCamargo/ticketfy/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/c8f29240ac491a6cfb03/test_coverage)](https://codeclimate.com/github/JosimarCamargo/ticketfy/test_coverage)

# This is a work in progress..

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

## How to run the test suite and linters
`docker-compose -f docker/docker-compose-test.yml up -d --build`

### Running linters
`docker-compose exec web bundle exec rubocop`
`docker-compose exec web bundle exec brakeman --no-pager`
`docker-compose exec web bundle exec rake factory_bot:lint`

### Running tests
When there is an update on DockerfileBaseTest is required to build the base test image, usually you can get one from the project on docker hub https://hub.docker.com/r/josimarcamargo/ticketfy

`docker build -t josimarcamargo/ticketfy:base_test . -f docker/DockerfileBaseTest --no-cache`

Without docker compose
`docker build -t josimarcamargo/ticketfy:test . -f docker/DockerfileTest --no-cache`

With docker compose
`docker-compose -f docker-compose-test.yml up -d --build`
`docker-compose exec web rake db:setup`
`docker-compose exec web bundle exec rspec`

### Debugging the app inside the container
When you attach the your terminal with the app, will be possible interact with the application using breaking points like binding.pry
To attach the terminal to the app container use:
`docker attach $(docker-compose ps -q app)`


You can also build, up and attach in one line
`dc up --build -d && docker attach $(docker-compose ps -q app)`

### Stop tests containers
`docker-compose down`

## Services (job queues, cache servers, search engines, etc.)
Work in progress..

## Deployment instructions

Building base image, this is usually done by docker hub, when there are changes on branch master.

`docker build -t josimarcamargo/ticketfy:base . -f docker/DockerfileBase --no-cache`


Building gem_cache image, this is usually done by docker hub, when there are changes on branch master

`docker build -t josimarcamargo/ticketfy:gem_cache . -f docker/DockerfileGemCache --no-cache`


Building production localmente, this is usually done by CI when there is changes on branch release/beta

`docker build  --build-arg RAILS_MASTER_KEY=$RAILS_MASTER_KEY --build-arg RAILS_ENV=production -t josimarcamargo/ticketfy:beta . -f docker/Dockerfile --no-cache`


Building release image, this is usually done by CI, this image used only by heroku to run deploy tasks like: rake db:migrate and etc

`docker build  --build-arg RAILS_MASTER_KEY=$RAILS_MASTER_KEY --build-arg RAILS_ENV=production -t registry.heroku.com/ticketfy-beta/release . -f docker/DockerfileReleaseHeroku --no-cache`


Setting heroku tag: web

`docker tag josimarcamargo/ticketfy:beta registry.heroku.com/ticketfy-beta/web`


Sending images to heroku container registry

`docker push registry.heroku.com/ticketfy-beta/web`
`docker push registry.heroku.com/ticketfy-beta/release`


Sending images to docker hub

`docker push josimarcamargo/ticketfy:beta`


Telling heroku to deploy the new image

with the heroku cli installed: `heroku container:release web release -a ticketfy-beta`

within CI can be done with a docker image, without installing the heroku cli: `docker run --rm -e HEROKU_API_KEY=$HEROKU_API_KEY josimarcamargo/heroku_cli container:release web release -a ticketfy-beta`


* Default User :
  - email: **admin@ticketfy**
  - pass: **changeme**

* Add Todo
