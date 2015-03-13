require File.expand_path('../boot', __FILE__)

require 'rubygems'
require 'roo'
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module ManthanErp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.autoload_paths += %W(#{Rails.root}/lib/form_objects)
    config.autoload_paths += %W(#{Rails.root}/lib/)
    config.autoload_paths += %W(#{Rails.root}/lib/menu)
    config.autoload_paths += %W(#{Rails.root}/lib/reports)
    config.autoload_paths += %W(#{Rails.root}/app/models/uploaders)
    config.autoload_paths += %W(#{Rails.root}/lib/payroll/)    
    config.autoload_paths += %W(#{Rails.root}/lib/payroll/pdf)   
    config.autoload_paths += %W(#{Rails.root}/lib/payroll/jobs)    
    config.autoload_paths += %W(#{Rails.root}/lib/payroll/errors)    

    config.roadie.enabled = true
    config.assets.enabled = true
    config.angular_templates.module_name    = 'templates'
    config.angular_templates.ignore_prefix  = 'templates/'
    config.angular_templates.markups        = %w(erb haml)
    config.angular_templates.htmlcompressor = false
    config.action_mailer.default_url_options = { host: 'localhost:3000' }
  end
end
