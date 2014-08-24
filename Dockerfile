FROM centurylinklabs/ruby-base:2.1.2

MAINTAINER Gregory Horion <i@gregory.io>

RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    libcurl4-openssl-dev \
    imagemagick

ENV RAILS_ENV development
ENV USE_ENV true

RUN /usr/sbin/useradd --create-home --home-dir /opt/locomotive_cms --shell /bin/bash locomotive_cms

# The repo of the app could be found here: https://github.com/gregory/cms.git
ADD . /opt/locomotive_cms/app
RUN chown -R locomotive_cms:locomotive_cms /opt/locomotive_cms/app

USER locomotive_cms
WORKDIR /opt/locomotive_cms/app
RUN bundle install --deployment
RUN bundle exec rake assets:precompile

CMD echo "Cms::Application.config.secret_token = '$(bundle exec rake secret)'" > config/initializers/secret_token.rb &&\
    bundle exec unicorn_rails  -p 3000
