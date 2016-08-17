FROM ruby:2.3.1

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1 <<< PRODUCTION ONLY

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY .irbrc /root
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

COPY . /usr/src/app
RUN bundle install

RUN apt-get update && apt-get install -y build-essential nodejs mysql-client libmysqlclient-dev --no-install-recommends

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
