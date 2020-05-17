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

# You will need first build the project or get an image with test setup
Images are available at docker hub
https://hub.docker.com/repository/docker/josimarcamargo/ticketfy
https://hub.docker.com/repository/docker/josimarcamargo/ticketfy-beta


building an image and up the test environment containers:
`docker-compose up -d --build tester`

### Running linters
```shell
docker-compose exec tester rubocop
docker-compose exec tester brakeman --no-pager
docker-compose exec tester rake factory_bot:lint
```

### Running tests
```shell
docker-compose exec tester rake db:setup
docker-compose exec tester rspec
```

### Developing
`docker-compose up -d --build app'

### Debugging the app inside the container
When you attach the your terminal with the app, will be possible interact with the application using breaking points like `binding.pry`
To attach the terminal to the app container use:
`docker attach $(docker-compose ps -q app)`


You can also build, up and attach in one line
`dc up --build -d && docker attach $(docker-compose ps -q app)`

### Stop tests containers
`docker-compose down`

## Services (job queues, cache servers, search engines, etc.)
Work in progress..

## Deployment instructions

Building production manually, this is usually done by CI when there is changes on branch master, for production and branch release/number for beta

`docker-compose build production`

Tag the production image
`docker tag ticketfy_production:latest registry.heroku.com/ticketfy-beta/web`

Building release image, this is usually done by CI, this image used only by heroku to run deploy tasks like: rake db:migrate and etc

`docker-compose build heroku_releaser`

Tag the Heroku releaser image
`docker tag ticketfy_heroku_releaser:latest registry.heroku.com/ticketfy-beta/release`

Sending images to heroku container registry
You will need to be logged first `heroku login`
´heroku container:login`
```shell
docker push registry.heroku.com/ticketfy-beta/web
docker push registry.heroku.com/ticketfy-beta/release
```

Tag image for docker hub
`docker tag ticketfy_production:latest josimarcamargo/ticketfy:beta`

Sending images to docker hub
`docker push josimarcamargo/ticketfy:beta`


Telling heroku to deploy the new image

with the heroku cli installed: `heroku container:release web release -a ticketfy-beta`

Some CI's has the heroku cli available, if that is not your case, this also can be done with a docker image, without installing the heroku cli: `docker run --rm -e HEROKU_API_KEY=$HEROKU_API_KEY josimarcamargo/heroku_cli container:release web release -a ticketfy-beta`


* Default User :
  - email: **admin@ticketfy**
  - pass: **changeme**

* Add Todo
