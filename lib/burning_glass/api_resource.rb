module BurningGlass
  class APIResource
    include Util::StringHelper
    extend Util::StringHelper

    class << self

      def deliver_request(method, url, params={})
        response = BurningGlass.client.request(method, url_base + url, params)
        response['result']
      end

      def url_base
      end

      def resource_name
        underscore(name).match(/([A-z]+\z)/)
        $1.downcase
      end

    end

  end
end
