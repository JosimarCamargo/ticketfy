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

You will need first build the project or get an image with test setup
Images are available at docker hub
https://hub.docker.com/repository/docker/josimarcamargo/ticketfy
https://hub.docker.com/repository/docker/josimarcamargo/ticketfy-beta

### Build and Database setup
Building an container image and up the test environment containers:
```shell
docker-compose up -d --build tester
docker-compose exec tester rake db:setup
```

### Running linters
```shell
docker-compose exec tester rubocop
docker-compose exec tester brakeman --no-pager
docker-compose exec tester rake factory_bot:lint
```

### Running tests
```shell
docker-compose exec tester rspec
```
[stopping the container](#Stop-containers)

### Developing
```shell
docker-compose up -d --build app
```

### Debugging the app inside the container
When you attach the your terminal with the app, will be possible interact with the application using breaking points like `binding.pry`
To attach the terminal to the app container use:
```shell
docker attach $(docker-compose ps -q app)
```

You can also build, up and attach in one line
```shell
docker-compose up --build -d && docker attach $(docker-compose ps -q app)
```

### Stop containers
```shell
docker-compose down
```

## Services (job queues, cache servers, search engines, etc.)
Work in progress..

### Building
The building and deploy is usually done by CI when there is changes on branch master for production and on branch release/number for beta.

The build deploy has 3 basics steps:
  - Set build enrollment variables
  - Get the cache images
  - Building the image

## Tagging the docker image
This project use the docker tag system as cache to improve the speed build and save some resources

## When building a DEV
*This it's used just to share/deploy an image on the early development stages*

Set build enrollment variables
You will must have the $BRANCH_NAME without slashes('/') set eg:
```shell
export BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD | tr '/' '_')"
```

Get the cache images
```shell
docker pull josimarcamargo/ticketfy:latest > /dev/null && echo "production image found" || echo "production image not found"
```

Build the docker image [following the instructions](#Developing), then tag and send the image to docker hub
```shell
docker tag ticketfy_app:latest josimarcamargo/ticketfy:$BRANCH_NAME-dev
docker push josimarcamargo/ticketfy:$BRANCH_NAME-dev
```

# When building a Beta image
*This is usually done in the branch release/number with the **VERSION file updated** to version to be released eg:*
Set build enrollment variables
```shell
export VERSION=`cat VERSION` # set a environment variable with the content of file VERSION
export DOCKER_IMAGE_CACHE_BRANCH_VERSION=josimarcamargo/ticketfy:$VERSION-beta # set the docker image that will be used as cache for this build
```

Get the cache images
```shell
docker pull $DOCKER_IMAGE_CACHE_BRANCH_VERSION > /dev/null && echo "branch image found" || echo "branch image not found"
docker pull josimarcamargo/ticketfy:latest > /dev/null && echo "production image found" || echo "production image not found" # needs to be improved, to run only when the 'docker pull $DOCKER_IMAGE_CACHE_BRANCH_VERSION' fail
```

Building the image
```shell
docker-compose build production
docker tag ticketfy_production:latest $DOCKER_IMAGE_CACHE_BRANCH_VERSION
```

# When building a production ready image
**This is should be done in the branch master**

Set build enrollment variables
```shell
export VERSION=`cat VERSION` # set a environment variable with the content of file VERSION
export DOCKER_IMAGE_CACHE_BRANCH_VERSION=josimarcamargo/ticketfy:$VERSION # set the docker image that will be used as cache for this build
```

Get the cache images
```shell
docker pull $DOCKER_IMAGE_CACHE_BRANCH_VERSION > /dev/null && echo "branch image found" || echo "branch image not found"
docker pull josimarcamargo/ticketfy:latest > /dev/null && echo "production image found" || echo "production image not found" # needs to be improved, to run only when the 'docker pull $DOCKER_IMAGE_CACHE_BRANCH_VERSION' fail
```

Building the image
```shell
docker-compose build production
docker tag ticketfy_production:latest josimarcamargo/ticketfy:$VERSION
docker tag ticketfy_production:latest josimarcamargo/ticketfy:latest
docker push josimarcamargo/ticketfy:$VERSION
docker push josimarcamargo/ticketfy:latest
```

# Building release image
Considering that you will deploy the docker image build on Heroku, you will need a Heroku releaser image

This is usually done by CI, this image used only by heroku to run deploy tasks like: rake db:migrate and etc, It's really IMPORTANT that you build an Heroku releaser image
with the same code that you are deploying at your environment, to avoid side effects like running more or less database migrations that you need

Here is used the same docker image as cache, that was used at the build step, so if the cache it's not been used, check if steps 'Set build enrollment variables' and 'Get the cache images' are done, and always respect if are building a release image for beta or production environment
```shell
docker-compose build heroku_releaser
```

Tag the Heroku releaser image for beta
```shell
docker tag ticketfy_heroku_releaser:latest registry.heroku.com/ticketfy-beta/release
```

Tag the Heroku releaser image for production
```shell
docker tag ticketfy_heroku_releaser:latest registry.heroku.com/ticketfy/release
```

## Deployment instructions
Sending images to heroku container registry
You will need to be logged first `heroku login`
´heroku container:login`
for beta
```shell
docker push registry.heroku.com/ticketfy-beta/web
docker push registry.heroku.com/ticketfy-beta/release
```

for production
```shell
docker push registry.heroku.com/ticketfy/web
docker push registry.heroku.com/ticketfy/release
```

Telling heroku to deploy the new image

with the heroku cli installed: `heroku container:release web release -a ticketfy-beta`

Some CI's has the heroku cli available, if that is not your case, this also can be done with a docker image, without installing the heroku cli:
```shell
docker run --rm -e HEROKU_API_KEY=$HEROKU_API_KEY josimarcamargo/heroku_cli container:release web release -a ticketfy-beta
```

* Default User :
  - email: **admin@ticketfy**
  - pass: **changeme**

* Add Todo
