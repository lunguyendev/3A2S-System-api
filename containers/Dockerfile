FROM ruby:2.7.1

ENV APP_HOME /opt/app
# Installation of dependencies
RUN DEPS='git make gcc g++ libpq-dev openssl ca-certificates tzdata libpq5 postgresql-client imagemagick libmagickwand-dev' \
  && UTIL_DEPS='vim less wget curl wait-for-it' \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends $DEPS $UTIL_DEPS \
  # Needed for certain gems
  build-essential \
  # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
  /var/lib/apt \
  /var/lib/dpkg \
  /var/lib/cache \
  /var/lib/log

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN cp /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
RUN bundle install

ADD . $APP_HOME

CMD []
