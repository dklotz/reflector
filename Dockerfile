FROM ruby:2.6.6-slim

# Install system libraries
RUN apt-get update -qq && \
  apt-get install -y build-essential

# 'deployment' means (among others) bundling to vendor/bundle and throwing errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global deployment 'true'

ENV APPLICATION_USER sinatra
ENV LANG C.UTF-8
ENV BUNDLE_WITHOUT "development test"
ENV PORT 4567
ENV RACK_ENV production

RUN useradd -ms /bin/bash ${APPLICATION_USER}
WORKDIR /usr/src/app
RUN chown -R ${APPLICATION_USER}:${APPLICATION_USER} /usr/src/app

USER $APPLICATION_USER

RUN gem install bundler

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install

COPY . .

CMD bundle exec rackup --host 0.0.0.0 --port $PORT
