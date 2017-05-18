FROM ubuntu:14.04
MAINTAINER Robson Jr "http://robsonjr.com.br"

ENV RUBY_MAJOR 2.4
ENV RUBY_VERSION 2.4.1

ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLER_VERSION 1.10.6
ENV APP_HOME /var/www

ENV HOME /root
ENV PATH $PATH:/root/.gem/ruby/$RUBY_MAJOR.0/bin

ENV DEBIAN_FRONTEND noninteractive

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git \
                                   zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev \
                                   libcurl4-gnutls-dev libffi-dev \
                                   software-properties-common pkg-config \
                                   libsqlite3-dev \
                                   libpq-dev postgresql-client \
                                   libmysqlclient-dev mysql-client \
                                   nginx \
                                   imagemagick libmagickwand-dev libmagickcore-dev \
 && apt-get clean

# libcurl3-dev

# Compile ruby from scratch
ADD rubies/ruby-$RUBY_VERSION.*   /tmp/
RUN chmod +x /tmp/ruby-$RUBY_VERSION.sh \
 && sync \
 && /tmp/ruby-$RUBY_VERSION.sh

COPY assets/gemrc /etc/gemrc
RUN chmod 644 /etc/gemrc
RUN gem update --system
RUN gem install bundler \
 && bundle config --global path "$GEM_HOME" \
 && bundle config --global bin "$GEM_HOME/bin"

RUN  echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Configure container startup
COPY assets/nginx.conf            /etc/nginx/sites-available/default
COPY assets/nginx-production.conf /etc/docker-container/nginx-production.conf
COPY assets/env-defaults          /etc/docker-container/env-defaults
COPY assets/puma.rb               /etc/docker-container/puma.rb
COPY assets/entrypoint            /usr/bin/

VOLUME ["/var/www", "/usr/local/bundle"]
EXPOSE 3000
WORKDIR $APP_HOME
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["run"]