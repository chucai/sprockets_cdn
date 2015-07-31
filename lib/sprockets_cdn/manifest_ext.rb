require 'sprockets/manifest'
require 'sprockets_cdn/assets_upload'
Sprockets::Manifest.class_eval do
  attr_accessor :remote_data
  def compile_with_cdn(*args)
    old_result = compile_without_cdn *args
    @remote_data = SprocketsCDN::AssetsUpload.setup assets, dir, logger
    old_result
  end
  alias_method :compile_without_cdn, :compile
  alias_method :compile, :compile_with_cdn
end
