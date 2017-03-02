FROM ruby:2.4.0

ADD . /opt/app/conversion_app

WORKDIR /opt/app/conversion_app

RUN bundle install

EXPOSE 4567

CMD bundle exec rackup --host 0.0.0.0 -p $PORT
