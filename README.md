# README

 [![CircleCI](https://circleci.com/gh/whimsical-rubyists/twitter-lite-api/tree/develop.svg?style=svg)](https://circleci.com/gh/whimsical-rubyists/twitter-lite-api/tree/develop) [![Coverage Status](https://coveralls.io/repos/github/whimsical-rubyists/twitter-lite-api/badge.svg?branch=develop)](https://coveralls.io/github/whimsical-rubyists/twitter-lite-api?branch=develop)

## INTRO

This is a mock of a twitter like application API. It is build on Rails 6.0.0 and Ruby 2.6.4 and uses MySQL  database.

## SETUP

Ensure you have Ruby-2.6.4,  Rails 6.0.0 and MySQL Server installed.

  01. Clone this Repo and `cd` to the project folder.

  ```bash
    git clone https://github.com/whimsical-rubyists/twitter-lite-api.git
  ```

  ```bash
  cd twitter-lite-api
  ```

  2. Install all dependencies.

  ```bash
    bundle install
  ```

  3. Copy `.env.template` as `.env` and edit the values to correspond to your local settings.

  ```bash
    cp .env.template .env
  ```

  4. Create the database and run migrations.

  ```bash
    rails db:create
  ```

  ```bash
    rails db:migrate
  ```

  5. Start the server.

  ```bash
    rails s
  ```

  6. You've started the server on port 3000. Read up on the documentation in from the following URL: `http://localhost:3000/api-docs`.

## Authors

- Gloria Odipo
- Mutuku Kyalo
