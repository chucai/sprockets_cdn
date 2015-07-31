# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprockets_cdn/version'

Gem::Specification.new do |spec|
  spec.name          = "sprockets_cdn"
  spec.version       = SprocketsCdn::VERSION
  spec.authors       = ["arnkorty"]
  spec.email         = ["arnkorty.fu@gmail.com"]

  spec.summary       = %q{a cdn assets for sprockets}
  spec.description   = %q{a cdn assets for sprockets, upload assets to upyun/qiniu}
  spec.homepage      = "https://github.com/arnkorty/sprockets_cdn"
  spec.license       = "MIT"

  spec.files         = Dir["README.md", "lib/**/*.rb", "LICENSE.txt"]
  # spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_dependency "sprockets", "~> 3.0"
  spec.add_dependency "ruby-hmac"
  spec.add_dependency "rest-client"
  spec.add_dependency "json"
  spec.add_dependency 'activesupport', '~> 4.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "babel-transpiler", "~> 0.6"
  spec.add_development_dependency "closure-compiler", "~> 1.1"
  spec.add_development_dependency "coffee-script-source", "~> 1.6"
  spec.add_development_dependency "coffee-script", "~> 2.2"
  spec.add_development_dependency "eco", "~> 1.0"
  spec.add_development_dependency "ejs", "~> 1.0"
  spec.add_development_dependency "execjs", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "nokogiri", "~> 1.3"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "sass", "~> 3.1"
  spec.add_development_dependency "uglifier", "~> 2.3"
  spec.add_development_dependency "yui-compressor", "~> 0.12"

  spec.add_development_dependency "pry"#, "~> 0.12"
end
