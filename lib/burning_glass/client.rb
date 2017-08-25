require 'json'

module BurningGlass
  class Client

    def initialize(opts)
      @opts = opts
    end

    def request(method, url, params={})
      request_options = opts(url)
      validate_configuration!(request_options)

      requester = Util::Requester.new(method, url, params, request_options)
      response = requester.call

      if response.code != '200'
        report_api_error!(response)
      else
        response = JSON.parse(response)
      end
    end

    private

    def opts(url)
      determine_requirements(url).inject({}) do |summ, key|
        summ[translated_key(key)] = @opts[key]
        summ
      end
    end

    def determine_requirements(url)
      case url
      when /\/insight\//
        Insight.requirements
      when /\/explorer\//
        Explorer.requirements
      else
        raise Error.new("The product you're attempting to access isn't supported")
      end
    end

    def translated_key(key)
      case key.to_s
      when /(insight|explorer)_secret/
        :token_secret
      when /(insight|explorer)_token/
        :token
      else
        key.to_sym
      end
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

  end
end
