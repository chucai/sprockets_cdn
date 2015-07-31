# -*- encoding: utf-8 -*-
require 'restclient'
require 'digest/md5'
require 'sprockets_cdn/adapters/base'
module SprocketsCDN
  module Adapters
    class Upyun < Base
      attr_accessor :username, :password
      def initialize opt
        super
        @username = opt[:username] || @access_key
        @password = md5(opt[:password] || @secret_key)
      end

      def uploading file, opt
        headers = {mkdir: true}

        key = get_key file, opt[:dir]
        body = File.new(file, 'rb')
        post_data = {
          body: body
        }
        date = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S GMT')

        sign = sign(:put, date, fullpath(key), body.size)
        headers[:Date] = date
        headers[:Authorization] = sign
        res = RestClient.put post_url(key), body, headers
        if res.code == 200
          URI.join(@asset_host, key).to_s
        end
        #  target = JSON.parse(res)['key']
        # URI.join(@asset_host, target).to_s
        generate_remote_url key
      end

      def post_url key
        "http://v0.api.upyun.com/#{@bucket}/" + key #).to_s
      end

      def base_url
        "http://v0.api.upyun.com"
      end

      def fullpath key
        File.join("/#{@bucket}", key).to_s
      end

      def md5 content
        Digest::MD5.hexdigest content
      end

      def sign(method, date, path, length)
        sign = "#{method.to_s.upcase}&#{path}&#{date}&#{length}&#{@password}"
        "UpYun #{@username}:#{md5(sign)}"
      end
    end
  end
end
