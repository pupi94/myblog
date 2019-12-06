FROM ruby:2.6.3-slim

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y wget build-essential postgresql-client libpq-dev apt-utils imagemagick cron curl gnupg apt-transport-https lsb-release openssh-client && rm -rf /var/lib/apt/lists/*

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install yarn -y && rm -rf /var/lib/apt/lists/*

# Setup Taobao source for node & yarn
RUN yarn config set registry https://registry.npm.taobao.org --global && yarn config set disturl https://npm.taobao.org/dist --global && npm config set registry https://registry.npm.taobao.org --global && npm config set disturl https://npm.taobao.org/dist --global
# Setup RubyChina Gem source for gem
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
# build cronjob log
RUN touch /var/log/cron.log && chmod go+rw /var/log/cron.log
# get latest bundler
RUN gem install bundler


ENV RAILS_ENV=production
# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/app
# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids
# Set our working directory inside the image
WORKDIR $RAILS_ROOT

ENV RAILS_MASTER_KEY=d6616fce51f8bb86a9452f6be037a321

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# Finish establishing our Ruby enviornment
RUN bundle install --retry 5 --without development:test
# Copy the Rails application into place
COPY . .
RUN yarn install
RUN bundle exec rails RAILS_ENV=production NODE_ENV=production webpacker:compile

EXPOSE 3000
# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD bundle exec rails db:migrate && puma -C config/puma.rb