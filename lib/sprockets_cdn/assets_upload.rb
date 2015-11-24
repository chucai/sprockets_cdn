require 'sprockets_cdn/configuration'
require "active_support/core_ext/string/inflections"
module SprocketsCDN
  class AssetsUpload
    class << self
      def setup assets, dir, logger
        return unless SprocketsCDN::Configuration.checked?
        require "sprockets_cdn/providers/#{SprocketsCDN::Configuration.config.provider}"
        kclass      = SprocketsCDN::Providers.const_get SprocketsCDN::Configuration.config.provider.classify
        client      = kclass.new SprocketsCDN::Configuration.config
        remote_data = {}

        lock      = Mutex.new

        keys          = assets.keys
        assets_count  = keys.size
        threads       = []
        threads_count = 20
        number        = assets_count / threads_count

        keys.in_groups_of(number, false).each do |group|
          threads << Thread.new do 
            group.each do |key|
              asset            = assets[key]
              target           = File.join(dir, asset)
              remote_target    = client.uploading target, dir: dir
              logger.info "Uploaded to #{remote_target}"
              lock.synchronize do
                remote_data[key] = remote_target
              end
            end
          end
        end

        threads.each(&:join)

        remote_data
      end
    end
  end
end
