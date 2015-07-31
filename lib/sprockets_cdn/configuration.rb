require 'active_support/configurable'
module SprocketsCDN
  class Configuration < ::ActiveSupport::Configurable::Configuration
    # attr_accessor :adapter, :bucket, :access_key, :secret_key, :asset_host
    def self.checked?
      config.adapter && config.bucket && config.access_key && config.secret_key && config.asset_host
    end
    def self.config
      @@config ||= ActiveSupport::Configurable::Configuration.new
    end
  end
end
