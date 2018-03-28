source 'https://gems.ruby-china.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'mysql2', '>= 0.3.18', '< 0.5'

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

gem 'defined_error', git: 'git@github.com:hpp19941122/defined_error.git'

group :development, :test do
  gem 'byebug', platform: :mri

  #封装RSpec 的程序，还包含了一些专为Rails 提供的功能
  gem "rspec-rails", "~> 3.5.2"
  #把Rails 生成测试数据默认使用的固件换成更好用的预构件
  gem "factory_girl_rails", "~> 4.8.0"
  #为预构件生成名字、Email 地址以及其他的示例数据
  gem "faker", "~> 1.7.3"
  gem "database_cleaner", "~> 1.5.3"
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]