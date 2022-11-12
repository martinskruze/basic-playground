FROM ruby:3.1.2
LABEL maintainer='martins.kruze@gmail.com'

RUN apt-get update -yqq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    libpq-dev \
    postgresql-client \
    libvips42 \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /rubybattle.com
WORKDIR /rubybattle.com
COPY Gemfile* /rubybattle.com/
RUN bundle install
COPY . /rubybattle.com
ENTRYPOINT ["./docker-entrypoint.sh"]
