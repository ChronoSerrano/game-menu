require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GameMenu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.bgg = {
      base_url: ENV['BGG_BASE_URL'] || 'https://www.boardgamegeek.com/xmlapi2',
      username: ENV['BGG_USERNAME']
    }
    config.logger = Logger.new(STDOUT)
    config.log_level = :DEBUG
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
