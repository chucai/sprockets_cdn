require 'sprockets_cdn/configuration'
module SprocketsCDN
  class AssetsUpload
    class << self
      def setup assets, dir, logger
        return unless SprocketsCDN::Configuration.checked?
        require "sprockets_cdn/adapters/#{SprocketsCDN::Configuration.adapter}"
        kclass = SprocketsCDN::Adapters.const_get SprocketsCDN::Configuration.adapter.classify
        client = kclass.new SprocketsCDN::Configuration.config
        assets.values.each do |asset|
          target = File.join(dir, asset)
          remote_target = client.uploading target, dir: dir
          logger.info "Uploaded to #{remote_target}"
        end
      end
    end
  end
end
