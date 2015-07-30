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
  spec.description   = %q{a cdn assets for sprockets}
  spec.homepage      = "https://github.com/arnkorty/sprockets_cdn"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir["README.md", "lib/**/*.rb", "LICENSE.txt"]
  # spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_dependency "sprockets", ">= 3.0.0"
  spec.add_dependency "ruby-hmac"
  spec.add_dependency "rest-client"
  spec.add_dependency "json"
  
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
