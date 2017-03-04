require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Myblog
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh'

    config.autoload_paths += %W(#{config.root}/lib)
    
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
