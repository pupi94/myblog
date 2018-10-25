FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential apt-utils mysql-client imagemagick cron curl openssh-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV='production'
ENV RACK_ENV='production' 
ENV RAILS_MASTER_KEY='d6616fce51f8bb86a9452f6be037a321'
ENV REDIS_CACHE='redis://172.17.0.3:6379/0'
ENV REDIS_SIDEKIQ='redis://172.17.0.3:6379/1'

ENV DB_HOST='172.17.0.2'
ENV DB_PASSWORD='123456'

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/app

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# Finish establishing our Ruby enviornment
RUN bundle install --retry 5 --without development:test

# Copy the Rails application into place
COPY . .

RUN bundle exec rake assets:precompile

EXPOSE 3000
# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD bundle exec rails db:migrate && puma -C config/puma.rb

