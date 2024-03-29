require File.expand_path('../boot', __FILE__)

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module WxCast
  class Application < Rails::Application
        config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
    
    
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/lib/**/*.rb)
    
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    
    
    
    config.paths.add "lib", glob: "**/*.rb"
    
    config.paths.add "app/api", glob: "**/*.rb"
    config.autoload_paths += %W(#{config.root}/app/api)
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :"zh-CN"
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local
    config.assets.precompile += %w(admin.css admin.js ckeditor.js mobile.js mobile.css wx_articles.js wx_articles.css editor.js)    
    
  end
end
