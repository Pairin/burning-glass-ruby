require 'net/http'
require 'json'

module BurningGlass
  module Util
    class Requester

      def initialize(method, url, params={}, opts={})
        @method = method
        @params = params
        @opts = opts
        @url = url
        @uri = URI.parse(request_url)
      end

      def call
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.use_ssl = @uri.scheme == 'https'
        request = build_request
        request.body = @params.to_json
        http.request(request)
      end

      private

      def build_request
        request = request_method_class.new(@uri.request_uri)
        request['Accept'] = 'application/json'
        request['Content-Type'] = 'application/json'
        request['Authorization'] = "OAuth #{@uri.query.gsub('&', ',')}"
        request
      end

      def request_url
        helper = Util::OauthHelper.new(@method, @url, {}, @opts)
        helper.full_url
      end

      def request_method_class
        method = @method.to_s.downcase.capitalize
        Util::StringHelper.constantize("Net::HTTP::#{method}")
      end

    end
  end
end
