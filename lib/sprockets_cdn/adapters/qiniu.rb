# -*- encoding: utf-8 -*-
require 'hmac-sha1'
require 'restclient'
require 'base64'
require 'json'
module SprocketsCDN
  module Adapters
    class Qiniu
      attr_accessor :access_key, :secret_key
      def initialize opt
        @access_key = opt[:access_key]
        @secret_key = opt[:secret_key]
        @asset_host = opt[:asset_host]
        @bucket     = opt[:bucket]
      end
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
        URI.join(@asset_host, target).to_s
      end

      def generate_put_policy file, opt
        opt[:saveKey] = file.sub(opt[:dir].to_s, '')
        opt[:scope] = @bucket
        opt[:deadline] = Time.now.to_i + 3600
        opt
      end

      def uptoken put_policy
        encoded_put_policy = urlsafe_base64_encode put_policy.to_json

        sign = HMAC::SHA1.new(@secret_key).update(encoded_put_policy).digest
        encoded_sign = urlsafe_base64_encode sign

        uptoken = "#{@access_key}:#{encoded_sign}:#{encoded_put_policy}"
      end

      def urlsafe_base64_encode content
        Base64.encode64(content).strip.gsub('+', '-').gsub('/','_').gsub(/\r?\n/, '')
      end
    end
  end
end
