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
#require "rails/test_unit/railtie"

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

    config.log_formatter = ::Logger::Formatter.new

    logger = ActiveSupport::Logger.new(
      Rails.root.join("log/#{Rails.env.to_s}.log"), 'daily')
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    wl_logger = ActiveSupport::Logger.new(
      Rails.root.join("log/wl_#{Rails.env.to_s}.log"), 'daily')
    wl_logger.formatter = ActiveSupport::Logger::SimpleFormatter.new
    config.wl_logger = ActiveSupport::TaggedLogging.new(wl_logger)

    # alias `wl_logger` to `Rails.wl_logger`
    Rails.instance_eval do
      def wl_logger; Rails.application.config.wl_logger; end
    end

  end
end
