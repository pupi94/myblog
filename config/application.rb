require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Myblog
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    config.autoload_paths += %W(#{config.root}/lib)
  end
end
