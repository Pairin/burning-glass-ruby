# Burning Glass Ruby

This gem is for accessing multiple Burning Glass APIs. Currently the Explorer & Insight APIs are supported.

## Installation

```ruby
  gem 'burningglass'
```

## Configuration

The minimum requirements to access Burning Glass APIs are a `Consumer Key` and a `Consumer Secret`. Each separate Burning Glass API Product has its own `Token` and `Token Secret`.

```ruby
  BurningGlass.configure do |options|
    options.consumer_key = 'CONSUMER_KEY'
    options.consumer_secret = 'CONSUMER_SECRET'

    # for insight API
    options.insight_token = 'INSIGHTAPITOKEN'
    options.insight_secret = 'INSIGHTAPISECRET'

    # for explorer API
    options.explorer_token = 'EXPLORERAPITOKEN'
    options.explorer_secret = 'EXPLORERAPISECRET'

    # requests default to sandbox API endpoints. Set production to true if
    # you want production APIs 
    options.production = true

  end
```
