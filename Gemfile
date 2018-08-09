source 'https://gems.ruby-china.org'

gem 'rails', '~> 5.2'
gem 'mysql2', '>= 0.3.18'
gem 'bootsnap', '~> 1.3'

gem 'puma', '~> 3.0'

gem 'jquery-rails'
#  压缩JavaScript
gem 'uglifier', '>= 1.3.0'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass', '~> 3.3.6'

gem 'therubyracer', platforms: :ruby
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# markdown
gem 'redcarpet', '~> 3.4'

gem 'kaminari', '~> 1.0'
gem 'carrierwave', '~> 1.2'
gem 'redis-rails', '~> 5.0'
gem 'devise', '~> 4.4'

gem 'sidekiq', '~> 5.1'
gem 'sidekiq-cron', '~> 0.6.3'

group :development, :test do
  gem 'byebug', platform: :mri

  #封装RSpec 的程序，还包含了一些专为Rails 提供的功能
  gem "rspec-rails", "~> 3.5.2"
  #把Rails 生成测试数据默认使用的固件换成更好用的预构件
  gem "factory_bot_rails", "~> 4.8.2"
  gem "database_cleaner", "~> 1.5.3"
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]