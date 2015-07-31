# -*- encoding: utf-8 -*-
require 'hmac-sha1'
require 'restclient'
require 'base64'
require 'json'
require 'sprockets_cdn/adapters/base'
module SprocketsCDN
  module Adapters
    class Qiniu < Base

      def uploading file, opt
        put_policy = generate_put_policy file, opt
        uptoken = uptoken(put_policy)
        post_data = {
          file: File.new(file, 'rb'),
          multipart: true,
          key: put_policy[:saveKey],
          token: uptoken
        }

        res = RestClient.post "http://up.qiniu.com/", post_data
        target = JSON.parse(res)['key']
        # URI.join(@asset_host, target).to_s
        generate_remote_url target
      end

      def generate_put_policy file, opt
        opt[:saveKey] = get_key file, opt[:dir] #file.sub(opt[:dir].to_s, '')
        opt[:scope] = @bucket
        opt[:deadline] = Time.now.to_i + 3600
        opt
      end

      def get_key file, dir
        path = super file, dir
        path = path[1..-1] if path =~ /^\//
        path
      end

      def uptoken put_policy
        encoded_put_policy = urlsafe_base64_encode put_policy.to_json

        sign = HMAC::SHA1.new(@secret_key).update(encoded_put_policy).digest
        encoded_sign = urlsafe_base64_encode sign

        uptoken = "#{@access_key}:#{encoded_sign}:#{encoded_put_policy}"
      end
    end
  end
end
