# GcoreApi
## !!!! Very alpha version !!!!
This is wrapper of REST API for G-Core CDN service (https://docs.gcorelabs.com/cdn/)
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gcore_api_rb', github: 'Lianowar/gcore_api'
```
And then execute:

    $ bundle
## Usage

Add initializer with configuration params
```ruby
GcoreApi.username = <gcore_username>
GcoreApi.password = <gcore_password>
GcoreApi.secret_key = <secret_passphrase to encrypt tokens file>
GcoreApi.logger = <custom_logger> # STDOUT by default
```

Call resources like
```ruby
GcoreApi::Users.list
GcoreApi::Users.find(123)
GcoreApi::Resources.list
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gcore_api_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GcoreApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Lianowar/gcore_api/blob/master/CODE_OF_CONDUCT.md).
