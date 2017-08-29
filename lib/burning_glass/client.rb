require 'json'

module BurningGlass
  class Client
    include Util::StringHelper

    SUCCESSFUL_REQUEST_VALUE = 'success'.freeze
    SANDBOX_URL = 'http://sandbox.api.burning-glass.com'.freeze
    PRODUCTION_URL = 'http://api.burning-glass.com'.freeze

    def initialize(opts)
      @opts = opts
    end

    def request(method, url, params={})
      request_options = opts(url)
      validate_configuration!(request_options)

      requester = Util::Requester.new(method, full_url(url), params, request_options)
      response = requester.call

      if response.code != '200'
        report_api_error!(response)
      else
        response_body = JSON.parse(response.body)
        if response_body['status'] != SUCCESSFUL_REQUEST_VALUE
          report_api_error!(response)
        else
          response_body
        end
      end
    end

    private

    def opts(url)
      api_product = determine_product(url)

      requirements(api_product).inject({}) do |summ, key|
        summ[key.to_sym] = (@opts[api_product] || {} )[key]
        summ
      end
    end

    def determine_product(url)
      case url
      when /\/insight\//
        :insight
      when /\/explorer\//
        :explorer
      else
        raise Error.new("The product you're attempting to access isn't supported")
      end
    end

    def requirements(product)
      constantize("BurningGlass::#{product.to_s.capitalize}").requirements
    end

    def validate_configuration!(config)
      missing_config = config.select{ |k,v| v.nil? }

      if !missing_config.empty?
        missing_config = missing_config.keys.join(", ")
        raise ConfigurationError.new("Required configuration is missing (#{missing_config})")
      end
    end

    def report_api_error!(response)
      raise APIError.new(response.code, response.message, response.body)
    end

    def full_url(url)
      if @opts.production
        PRODUCTION_URL + url
      else
        SANDBOX_URL + url
      end
    end

  end
end
