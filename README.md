# SprocketsCdn

#### A Sprockets CDN extendsion gem, upload assets to  upyun/qiniu.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sprockets_cdn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sprockets_cdn

## Usage
```ruby
# config/initializes/sprockets_cdn.rb
SprocketsCDN.config do |config|
  config.bucket = "bucket name"
  config.asset_host = "asset host"
  ## for qiniu
  config.provider = 'qiniu'
  config.access_key = "xxxx"
  config.secret_key = "xxxx"
  ## for upyun
  config.provider = 'upyun'
  config.access_key = "as username"
  config.secret_key = "as password"
end
```
then
```bash
## run compile assets,it will upload to cdn after compile
RAILS_ENV=production bundle exec rake assets:precompile
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arnkorty/sprockets_cdn. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
