FROM ruby:2.1

MAINTAINER AMar4enko <amar4enko@gmail.com>

RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    libcurl4-openssl-dev \
    imagemagick

ENV RAILS_ENV production
ENV USE_ENV true

# The repo of the app could be found here: https://github.com/gregory/locomotive_cms.git
ADD . /opt/locomotive_cms/app

WORKDIR /opt/locomotive_cms/app
RUN bundle install --deployment
RUN bundle exec rake assets:precompile

RUN echo "Cms::Application.config.secret_token = '$(bundle exec rake secret)'" > config/initializers/secret_token.rb

EXPOSE 80

CMD bundle exec unicorn_rails -p 80
