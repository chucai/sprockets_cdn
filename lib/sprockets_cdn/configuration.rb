module SprocketsCDN
  class Configuration
    cattr_accessor :adapter, :bucket, :access_key, :secret_key, :asset_host

    def self.checked?
      @@adapter && @@bucket && @@access_key && @@secret_key && @@asset_host
    end
    def self.config
      {
        bucket: @@bucket,
        access_key: @@access_key,
        secret_key: @@secret_key,
        asset_host: @@asset_host
      }
    end
  end
end
