require 'addressable/uri'
require 'cgi'
require 'base64'
require 'openssl'
require 'securerandom'

module BurningGlass
  module Util
    class OauthHelper
      attr_reader :url_params

      DEFAULT_OAUTH_OPTIONS = {
        version: '1.0',
        signature_method: 'HMAC-SHA1',
      }.freeze

      def initialize(method, url, params, options)
        options = merge_defaults(options)

        @consumer_secret = options.delete(:consumer_secret)
        @token_secret = options.delete(:token_secret)
        @url_params = params.merge(prepend_oauth_to_key(options))
        @method = method.to_s.upcase
        @url = Addressable::URI.parse(url)
      end

      def signature_base
        @url_params.delete(:oauth_signature)

        [
          @method,
          @url.to_s,
          url_with_params.query
        ].map{ |v| CGI.escape(v) }.join('&')
      end

      def full_url
        append_signature_to_params
        url_with_params.to_s
      end

      private

      def secret_key
        [CGI.escape(@consumer_secret), CGI.escape(@token_secret)].join('&')
      end

      def url_with_params
        @url.dup.tap{ |url| url.query_values = url_params }
      end

      def append_signature_to_params
        @url_params[:oauth_signature] = hmac_sha1_signature(secret_key, signature_base)
      end

      def prepend_oauth_to_key(options)
        Hash[options.map{ |key, value| ["oauth_#{key}".to_sym, value] }]
      end

      def hmac_sha1_signature(key, signature_string)
        digest = OpenSSL::Digest.new('sha1')
        hmac = OpenSSL::HMAC.digest(digest, key, signature_string)
        Base64.strict_encode64(hmac)
      end

      def merge_defaults(opts)
        opts.merge!(
          timestamp: Time.now.to_i.to_s,
          nonce: SecureRandom.uuid
        )

        DEFAULT_OAUTH_OPTIONS.dup.merge(opts)
      end

    end
  end
end
