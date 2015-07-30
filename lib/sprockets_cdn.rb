require "sprockets_cdn/version"
require "sprockets_cdn/manifest_ext"
require "sprockets_cdn/configuration"
module SprocketsCDN
  def self.config &block
    yield SprocketsCDN::Configuration
    raise "config isn't setting" unless SprocketsCDN::Configuration.checked?
    if defined? Rails
      Rails.application.config.asset_host ||= SprocketsCDN::Configuration.asset_host
    end
  end
  # Your code goes here...
end
