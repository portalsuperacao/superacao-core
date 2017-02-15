require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SuperacaoCore
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths += %W(#{config.root}/app/services)

    config.superacao = config_for(:superacao)

    config.paperclip_defaults = { storage: :fog,
                                  fog_credentials: {
                                    provider: 'Google',
                                    google_project: ENV['GOOGLE_CLOUD_STORAGE_PROJECT'],
                                    google_storage_access_key_id: ENV['GOOGLE_CLOUD_STORAGE_ACCESS_KEY'],
                                    google_storage_secret_access_key: ENV['GOOGLE_CLOUD_STORAGE_SECRET_KEY']
                                  },
                                  fog_directory: ENV['GOOGLE_CLOUD_STORAGE_BUCKET'],
                                  fog_host: "http://storage.googleapis.com/#{ENV['GOOGLE_CLOUD_STORAGE_BUCKET']}"
                                }
  end
end
