require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module DocumentApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '**/')]
    config.eager_load_paths << Rails.root.join('lib')
    config.i18n.default_locale = :ru
    config.time_zone = 'Krasnoyarsk'
    config.active_record.belongs_to_required_by_default = false
    config.active_record.yaml_column_permitted_classes = [Symbol, Time]
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
  end
end
