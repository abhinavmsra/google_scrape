require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GoogleScraper
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(
    #{config.root}/lib
      #{config.root}/app/services
      #{config.root}/app/controllers/concerns
      #{config.root}/app/models/concerns
      #{config.root}/app/uploaders
      #{config.root}/app/datatables/concerns
    )
    config.public_file_server.enabled = true
    # Enable the asset pipeline
    config.assets.enabled = true
  end
end
