# from ruby MRI version 3.1.2:
FROM ruby:3.1.2

# set up contact person for our project
LABEL maintainer='martins.kruze@gmail.com'

# remove all downloaded lists with rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    libpq-dev \
    postgresql-client \
    libvips42 \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# to be sure - lets set up lang
ENV LANG=C.UTF-8 

# update and install new bundler
RUN gem update --system && gem install bundler

# make application direcory
RUN mkdir /rails_7

# change working direcotry to it
WORKDIR /rails_7

# copy Gemfile and Gemfile.lock to our working direcotory
COPY Gemfile* /rails_7/

# install gems
RUN bundle install

# copy our project
COPY . /rails_7

# script that removes tmp/pids/server.pid file if it exists (need ensure it is executable with chmod +x docker-entrypoint.sh)
ENTRYPOINT ["./docker-entrypoint.sh"]