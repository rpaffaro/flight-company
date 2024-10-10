# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.4
FROM registry.docker.com/library/ruby:$RUBY_VERSION

WORKDIR /app
RUN apt-get update

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

RUN chmod +x ./bin/docker-entrypoint
ENTRYPOINT ["./bin/docker-entrypoint"]

ENV RAILS_ENV production
EXPOSE 80
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "80"]
