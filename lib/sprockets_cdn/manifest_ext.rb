require 'sprockets/manifest'
require 'sprockets_cdn/assets_upload'
Sprockets::Manifest.class_eval do
  def compile_with_cdn(*args)
    compile_without_cdn *args
    SprocketsCDN::AssetsUpload.setup assets, dir, logger
  end
  alias_method :compile_without_cdn, :compile
  alias_method :compile, :compile_with_cdn
end
