require 'net/http'
require 'json'

module BurningGlass
  module Util
    class Requester
      include StringHelper

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
        request.body = @params.to_json if [:post, :put].include?(@method)
        http.request(request)
      end

      private

      def build_request
        request = request_method_class.new(uri_with_params.request_uri)
        request['Accept'] = 'application/json'
        request['Content-Type'] = 'application/json'
        request['Authorization'] = "OAuth #{authorization_header(@uri.query)}"
        request
      end

      def request_url
        helper = Util::OauthHelper.new(@method, @url, @params, @opts)
        helper.full_url
      end

      def request_method_class
        method = @method.to_s.downcase.capitalize
        constantize("Net::HTTP::#{method}")
      end

      def authorization_header(query_string)
        query_string.split("&").map do |q|
          groups = q.split("=")
          "#{groups[0]}=\"#{groups[1]}\""
        end.join(",")
      end

      def uri_with_params
        URI.parse(@url + '?' + hash_to_query_string(@params))
      end

    end
  end
end
