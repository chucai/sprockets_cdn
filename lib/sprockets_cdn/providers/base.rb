# -*- encoding: utf-8 -*-
require 'base64'
module SprocketsCDN
  module Providers
    class Base
      attr_accessor :access_key, :secret_key
      def initialize opt
        @access_key = opt[:access_key]
        @secret_key = opt[:secret_key]
        @asset_host = opt[:asset_host]
        @bucket     = opt[:bucket]
      end

      def get_key full_path, base_dir
        if defined? Rails
          asset_root = Rails.root.join('public').to_s
          asset_root = base_dir unless base_dir.include?(asset_root)
          full_path.sub(asset_root, '')
        else
          full_path.sub(base_dir, '')
        end
      end

      def urlsafe_base64_encode content
        Base64.encode64(content).strip.gsub('+', '-').gsub('/','_').gsub(/\r?\n/, '')
      end

      def generate_remote_url path
        URI.join(@asset_host, path)
      end
    end
  end
end
