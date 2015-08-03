require "sprockets_cdn/version"
require "sprockets_cdn/manifest_ext"
require "sprockets_cdn/configuration"
module SprocketsCDN
  def self.config &block
    yield SprocketsCDN::Configuration.config
    ## fix version 0.1.0
    SprocketsCDN::Configuration.config.provider ||= SprocketsCDN::Configuration.adapter
    if defined? Rails
      ActionController::Base.asset_host =
        Rails.application.config.action_controller.asset_host ||=
        SprocketsCDN::Configuration.config.asset_host
    end
    raise "config isn't setting" unless SprocketsCDN::Configuration.checked?
  end
  # Your code goes here...
end
