FROM ruby:2.7-alpine
WORKDIR /opt/project
COPY Gemfile /opt/project/Gemfile
COPY Gemfile.lock /opt/project/Gemfile.lock
RUN pwd
RUN apk add --update \
  bash \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  yarn \
  tzdata \
  && rm -rf /var/cache/apk/*
RUN bundle install
COPY . /opt/project

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
