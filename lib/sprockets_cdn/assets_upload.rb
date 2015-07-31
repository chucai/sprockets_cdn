require 'sprockets_cdn/configuration'
require "active_support/core_ext/string/inflections"
module SprocketsCDN
  class AssetsUpload
    class << self
      def setup assets, dir, logger
        return unless SprocketsCDN::Configuration.checked?
        require "sprockets_cdn/adapters/#{SprocketsCDN::Configuration.config.adapter}"
        kclass = SprocketsCDN::Adapters.const_get SprocketsCDN::Configuration.config.adapter.classify
        client = kclass.new SprocketsCDN::Configuration.config
        remote_data = {}
        assets.each do |key, asset|
          target = File.join(dir, asset)
          remote_target = client.uploading target, dir: dir
          logger.info "Uploaded to #{remote_target}"
          remote_data[key] = remote_target
        end
        remote_data
      end
    end
  end
end
