# frozen_string_literal: true

require_relative 'boot'

require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_job/railtie"
require "action_cable/engine"
# require "action_mailbox/engine"
require "action_text/engine"
require "rails/test_unit/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Imenu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Brasilia'
    config.i18n.default_locale = 'pt-BR'
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :sidekiq

    config.action_view.field_error_proc = ->(html_tag, _instance) { html_tag }

    routes.default_url_options[:host] = ENV.fetch('DOMAIN_NAME', 'localhost:3000')
  end
end
