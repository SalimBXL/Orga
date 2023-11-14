require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Orga
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.before_configuration do
      env_file = File.join(Rails.root, '.env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exist?(env_file)
    end

    config.active_record.legacy_connection_handling = false

    #Rails.logger = Logger.new(STDOUT)
    #config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    #nfig.web_console.permissions = '10.0.2.2'
    #config.web_console.whitelisted_ips = '10.0.2.2'
  end
end
