# Mina::Foreman

Foreman plugin for [mina](https://github.com/mina-deploy/mina)

## Maintainers wanted

We do not use foreman so we are looking for mainterners.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-foreman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-foreman

## Usage

   require 'mina/foreman'
   set :application, "app-name"

   task :deploy => :environment do
     deploy do
       ...
       invoke 'foreman:export'
       ...
     end

     to :launch do
       invoke 'foreman:restart'
     end
   end

# Configuration

    set :foreman_app # default:  -> { "#{fetch(:domain)}_#{fetch(:rails_env)}" }
    set :foreman_user # default: -> { user }
    set :foreman_log # default:  -> { "#{deploy_to!}/#{shared_path}/log" }
    set :foreman_sudo # default: true
    set :foreman_format # default: 'upstart'
    set :foreman_location # default: '/etc/init'
    set :foreman_procfile # default: 'Procfile'

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mina-foreman. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
