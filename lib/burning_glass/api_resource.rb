module BurningGlass
  class APIResource
    include Util::StringHelper
    extend Util::StringHelper

    class << self

      def url_with_params(url, params={})
        wo_params = url_base + url
        params.empty? ? wo_params : wo_params + hash_to_query_string(params)
      end

      def deliver_request(method, url, params={})
        response = BurningGlass.client.request(method, url_with_params(url, params))
        response['result']
      end

      def url_base
      end

    end

  end
end
