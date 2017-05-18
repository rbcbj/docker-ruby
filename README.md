# Docker image for ruby

Dockerize your ruby environment

## Usage

Environment variables:

* `APP_ENV` defines environment mode (defaults to `production`)
* `APP_BUNDLE` flag to check if should run `bundle install` on startup (defaults to `y`)

Commands:

* `assets` compile assets
* `bundle|bundler` run `bundle install` command
* `run` run ruby container exposing port `3000`

Volumes:

* `/var/www` application path
* `/usr/local/bundle` bundler cache

## Rubies available

* `2.4.1` - latest stable release
* `2.2.2`
