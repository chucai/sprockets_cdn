require "sprockets_cdn/version"
require "sprockets_cdn/manifest_ext"
require "sprockets_cdn/configuration"
module SprocketsCDN
  def self.config &block
    yield SprocketsCDN::Configuration.config
    if defined? Rails
      ActionController::Base.asset_host =
        Rails.application.config.action_controller.asset_host ||=
        SprocketsCDN::Configuration.config.asset_host
    end
    raise "config isn't setting" unless SprocketsCDN::Configuration.checked?
  end
  # Your code goes here...
end
