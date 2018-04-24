require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Myblog
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh'

    config.autoload_paths += %W(#{config.root}/lib)

    config.cache_store = :redis_store, {
      host: "127.0.0.1",
      port: 6379,
      db: 0,
      namespace: "cache"
    },{ expire_after: 1.day }

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: true,
        routing_specs: true,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

  end
end