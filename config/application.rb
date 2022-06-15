require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CryptoDeck
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_storage.variant_processor = :mini_magick
    # Configuration for the application, engines, and railties goes here.
    #
    secret_key_base: b26e94eade57cde374e7cbd0746daf4c6e4801a2507623b073bdba553c3f8866312d7cca4b37315c57a1f30adf406898009a39c200549647d14e3a675802a577

    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
