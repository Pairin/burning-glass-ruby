# Burning Glass Ruby

This gem is for accessing multiple Burning Glass APIs. Currently the Explorer & Insight APIs are supported.

Tested w/ RUBY 2.2

## Installation

```ruby
  gem 'burningglass'
```

## Configuration
Each separate Burning Glass API Product has its own `Consumer Key`, `Consumer Secret`, `Token`, and `Token Secret`. Each API accepts it's own hash of parameters.

```ruby
  BurningGlass.configure do |options|

    # for insight API
    options.insight = {
      consumer_key: 'INSIGHTCONSUMERKEY',
      consumer_secret: 'INSIGHTCONSUMERSECRET',
      token: 'INSIGHTAPITOKEN',
      token_secret: 'INSIGHTAPISECRET'
    }

    # for explorer API
    options.explorer = {
      consumer_key: 'EXPLORERCONSUMERKEY',
      consumer_secret: 'EXPLORERCONSUMERSECRET',
      token: 'EXPLORERAPITOKEN',
      token_secret: 'EXPLORERAPISECRET'
    }
    # requests default to sandbox API endpoints. Set production to true if
    # you want production APIs
    options.production = true

  end
```
