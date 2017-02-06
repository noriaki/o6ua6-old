require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module O6ua6
  class Application < Rails::Application
    config.paths.add 'app/callbacks', eager_load: true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Asia/Tokyo'

    # except production environment, assets serve from webpack-dev-server
    config.action_controller.asset_host = 'localhost:8080'

    config.log_formatter = ::Logger::Formatter.new

    logger = ActiveSupport::Logger.new(
      Rails.root.join('log', "#{Rails.env}.log"), 'daily'
    )
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
end
