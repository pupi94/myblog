# frozen_string_literal: true

source "https://gems.ruby-china.com"

ruby "2.6.3"

gem "pg", ">= 0.18", "< 2.0"
gem "rails", "~> 6.0"

gem "bootsnap", "~> 1.3", require: false
gem "puma", "~> 4.3"

gem "jbuilder", "~> 2.5"
gem "jb"
gem "pagy"

gem "rails-i18n"

gem "webpacker"
gem "turbolinks", "~> 5"
gem "sass-rails", "~> 5.0"

gem "devise", "~> 4.7"
gem "devise-i18n", "~> 1.6"

gem "searchkick"
gem "oj" # increase json serialize performance

gem "sidekiq"

group :development, :test do
  gem "byebug", platform: :mri

  gem "database_cleaner"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "shoulda-matchers"

  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-performance"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
