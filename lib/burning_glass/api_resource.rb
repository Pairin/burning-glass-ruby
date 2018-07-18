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

      def parse_singular_resource(resource_data)
        new(resource_data)
      end

      def parse_multiple_resources(resources_data, metadata)
        Results.new(
          resources_data.map{ |rd| parse_singular_resource(rd) },
          metadata
        )
      end

    end

    def initialize(data={})
      set_accessors(data)
    end

    private

    def metaclass
      class << self; self; end
    end

    def set_accessors(data)
      data.each do |(k,v)|
        metaclass.instance_eval do
          method_name = underscore(k)
          define_method(method_name) { v }
        end
      end
    end

  end
end
