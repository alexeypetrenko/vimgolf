require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vimgolf
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable heroku logger
    config.action_controller.logger = Logger.new(STDOUT)

    # config.middleware.use "::ExceptionNotifier" , :email_prefix => "[vimgolf] ",
                               # :sender_address => %{"vimgolf" <exception@vimgolf.com>},
                               # :exception_recipients => %w{ilya@igvita.com}

    # Have the SQLite3 adapter represent booleans as integers. The default
    # setting of false uses 't' and 'f' to represent them, but that is
    # discouraged and deprecated. Since we currently don't have boolean fields
    # in the database, it's safe to proceed with this change without requiring
    # a migration.
    config.active_record.sqlite3.represent_boolean_as_integer = true

    config.cache_store = :mem_cache_store,
                    (ENV["MEMCACHIER_SERVERS"] || "").split(","),
                    {
                      :username => ENV["MEMCACHIER_USERNAME"],
                      :password => ENV["MEMCACHIER_PASSWORD"],
                      :failover => true,
                      :socket_timeout => 1.5,
                      :socket_failure_delay => 0.2
                    }

    config.assets.enabled = true
    config.assets.version = "1.0"

    config.generators do |g|
      g.orm :active_record
    end
  end
end
